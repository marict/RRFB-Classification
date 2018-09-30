"""
Validate our RNN. Basically just runs a validation generator on
about the same number of videos as we have in our test set.
"""
from keras.callbacks import TensorBoard, ModelCheckpoint, CSVLogger
from models import ResearchModels
from data import DataSet

import numpy as np
import csv

def validate(data_type, model, saved_model,
             class_limit, image_shape = None):
    batch_size = 32

    print "Got here!"
    seq_length = 40
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

    X,y, Z = data.get_all_sequences_in_memory_names('test','features')
    print "X len: " + str(len(X))
    print "y len: " + str(len(y))
    print "Z len: " + str(len(Z))

    names = []
    # Process names 
    for row in Z:
        foo = row[2].split("_")
        foo.pop(0)
        names.append(foo)
    print names
        
    # Get the model.
    # rm = ResearchModels(len(data.classes), model, seq_length, saved_model)
    rm = ResearchModels(3, model, seq_length, saved_model)

    print "Beggining prediction"
    a = rm.model.predict(X,verbose = 1)
    b = np.zeros_like(a)
    b[np.arange(len(a)), a.argmax(1)] = 1
    class_result = b
    print "\t result: " + str(class_result)
    print "\t total result: " + str(np.sum(b,axis=0))

    # now combine arrays
    total = np.hstack((names,b))
    print total

    # save as csv
    with open('foo.csv','w') as output:
        writer = csv.writer(output,lineterminator='\n')
        writer.writerow(["device","trip","starttime","endttime","Flashing","Not_Flashing","Unknown"])
        writer.writerows(total)


    """
    # Write results to csv file
    myFile = open("first_output_1.csv",'w')
    with myFile
        writer = csv.writer(myFile)
        for 


    
    names, preds = [],[]
    for i in range(len(X)):
        x = X[i]
        print("\t x = " + str(x))
        name = Z[i]
        pred = rm.model.predict(x, batch_size = 1)
        print "\t Predicted class: " + str(pred) + " for name: " + str(name)
        names.append(name)
        preds.append(pred)
    """

    print "\t\t END"

def main():
    model = 'mlp'
    saved_model = 'data/checkpoints/bestprec.hdf5'

    if model == 'conv_3d' or model == 'lrcn':
        data_type = 'images'
        image_shape = (80, 80, 3)
    else:
        data_type = 'features'
        image_shape = None

    validate(data_type, model, saved_model=saved_model,
             image_shape=image_shape, class_limit=1)

if __name__ == '__main__':
    main()
