# RRFB-Classification
Classification of RRFB traffic lights. Data is protected by IRB.
This was a research project done under UW HFSM lab.

The goal of the project was to label forward facing dash cam video data for the presence of blinking RRFB lights.\n
The data has been scrubbed from this repository.\n
The data was first wrangled from a larger database through GPS to narrow down videos to those within the range of an RRFB.\n
Then a Neural net classifier was trained on the data to identify flashing RRFBs, not flashing RRFBs and unknown videos.\n
The classifier achieved an approximate f1 score of 80% on test data. \n
The classifier did not end up being used in the final data wrangling step, but a lot of the scripts used to increase manual labeling did end up being utilized in the project.\n
\n
\n
Based off of this blog post: https://blog.coast.ai/five-video-classification-methods-implemented-in-keras-and-tensorflow-99cad29cc0b5
 
Libraries of Note used:
Keras with Tensorflow backend
