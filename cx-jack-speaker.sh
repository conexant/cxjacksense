#!/bin/bash

#specify the device path
CXSNDDEV="hw:0"

amixer -D$CXSNDDEV cset name='I2S DAC1L Switch' on
amixer -D$CXSNDDEV cset name='I2S DAC1R Switch' on
amixer -D$CXSNDDEV cset name='PortG Out En Switch' on

