# RRFB-Classification
Classification of RRFB traffic lights. Data is protected by IRB.
This was a research project done under UW HFSM lab.

The goal of the project was to label forward facing dash cam video data for the presence of blinking RRFB lights.
The data has been scrubbed from this repository.
The data was first wrangled from a larger database through GPS to narrow down videos to those within the range of an RRFB.
Then a Neural net classifier was trained on the data to identify flashing RRFBs, not flashing RRFBs and unknown videos.
The classifier achieved an approximate f1 score of 80% on test data. 
The classifier did not end up being used in the final data wrangling step, but a lot of the scripts used to increase manual labeling did end up being utilized in the project.
