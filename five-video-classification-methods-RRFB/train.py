"""
Train our RNN on extracted features or images.
"""
from keras.callbacks import TensorBoard, ModelCheckpoint, EarlyStopping, CSVLogger
from models import ResearchModels
from data import DataSet
import time
import os.path

import numpy as np
from keras.callbacks import Callback
from sklearn.metrics import confusion_matrix, f1_score, precision_score, recall_score

class Metrics(Callback):
    def on_train_begin(self, logs = {}):
        self.val_f1s = [-float('inf')]
        #self.val_recalls = []
        self.val_precisions = [-float('inf')]

    def on_epoch_end(self,epoch,logs = {}):
            
        # note: use self.validation_data instead of self.model.validation_data
        val_predict = (np.asarray(self.model.predict(self.validation_data[0]))).round()

        val_targ = self.validation_data[1]
         
        # Must use average = None for multiclass
        #f1 = f1_score(val_targ, val_predict, average = None)[0]
        
        _val_recall = recall_score(val_targ, val_predict, average = None)
        _val_precision = precision_score(val_targ, val_predict, average=None)
        _flashing_precision = _val_precision[0];
        #self.val_recalls.append(_val_recall)
       

        #Save model if Flashing Precision
        
        if _flashing_precision > self.val_precisions[len(self.val_precisions)-1]:
            filepath=os.path.join('data','checkpoints','bestprec.hdf5')
            print("\t  Flashing Precision improved. Saving model!")
            self.val_precisions.append(_flashing_precision)
            self.model.save_weights(filepath)
        else:
            print("\t Flashing Precision did not improve")

        print("\t Precision: " + str(_val_precision))
        print("\t Precisions: " + str(self.val_precisions))
        return

def train(data_type, seq_length, model, saved_model=None,
          class_limit=None, image_shape=None,
          load_to_memory=False, batch_size=32, nb_epoch=100):
    # Helper: Save the model.
    checkpointer = ModelCheckpoint(
        filepath=os.path.join('data', 'checkpoints', model + '-' + data_type + \
            '.best2.hdf5'),
        verbose=1,
        save_best_only=True)

    # Helper: TensorBoard
    tb = TensorBoard(log_dir=os.path.join('data', 'logs', model))

    # Helper: Stop when we stop learning.
    early_stopper = EarlyStopping(patience=5)

    # Helper: Save results.
    timestamp = time.time()
    csv_logger = CSVLogger(os.path.join('data', 'logs', model + '-' + 'training-' + \
        str(timestamp) + '.log'))

    # Get the data and process it.
    if image_shape is None:
        data = DataSet(
            seq_length=seq_length,
            class_limit=class_limit
        )
    else:
        data = DataSet(
            seq_length=seq_length,
            class_limit=class_limit,
            image_shape=image_shape
        )

    # Get samples per epoch.
    # Multiply by 0.7 to attempt to guess how much of data.data is the train set.
    steps_per_epoch = (len(data.data) * 0.7) // batch_size

    if load_to_memory:
        # Get data.
        X, y = data.get_all_sequences_in_memory('train', data_type)
        X_test, y_test = data.get_all_sequences_in_memory('test', data_type)
    else:
        # Get generators.
        generator = data.frame_generator(batch_size, 'train', data_type)
        val_generator = data.frame_generator(batch_size, 'test', data_type)

    # Get the model.
    rm = ResearchModels(len(data.classes), model, seq_length, saved_model)

    # Balance the class weights!
    print("setting weights!:")
    flashing = 0
    not_flashing = 0
    unknown = 0
    for label in y:
        if label[0]:
            flashing = flashing + 1
        elif label[1]:
            not_flashing = not_flashing + 1
        else:
            unknown = unknown + 1
    raw = [flashing,not_flashing,unknown]
    dist = [sum(raw)/float(i) for i in raw]
    class_weights = {1:dist[0], 2:dist[1], 3:dist[2]}
    print(class_weights)

    # Use custom metrics because acc is garbage
    print("setting metrics!")
    metrics = Metrics()

    # Fit!
    if load_to_memory:
        # Use standard fit.
        rm.model.fit(
            X,
            y,
            batch_size=batch_size,
            validation_data=(X_test, y_test),
            verbose=1,
            callbacks=[tb,metrics],
            epochs=nb_epoch)
    else:
        # Use fit generator.
        rm.model.fit_generator(
            generator=generator,
            steps_per_epoch=steps_per_epoch,
            epochs=nb_epoch,
            verbose=1,
            callbacks=[tb, early_stopper, csv_logger, checkpointer],
            validation_data=val_generator,
            validation_steps=40,
            workers=4)

def main():
    """These are the main training settings. Set each before running
    this file."""
    # model can be one of lstm, lrcn, mlp, conv_3d, c3d
    model = 'mlp'
    #saved_model = "data/checkpoints/mlp-features.best.hdf5"
    saved_model = None    
    class_limit = 3  # int, can be 1-101 or None
    seq_length = 40
    load_to_memory = True  # pre-load the sequences into memory
    batch_size = 32
    nb_epoch = 30

    # Chose images or features and image shape based on network.
    if model in ['conv_3d', 'c3d', 'lrcn']:
        data_type = 'images'
        image_shape = (80, 80, 3)
    elif model in ['lstm', 'mlp']:
        data_type = 'features'
        image_shape = None
    else:
        raise ValueError("Invalid model. See train.py for options.")

    train(data_type, seq_length, model, saved_model=saved_model,
          class_limit=class_limit, image_shape=image_shape,
          load_to_memory=load_to_memory, batch_size=batch_size, nb_epoch=nb_epoch)

if __name__ == '__main__':
    main()
