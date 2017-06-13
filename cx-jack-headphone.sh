#!/bin/bash

#no:HP through DAC1(DSP) , yes:HP through DAC2.
USING_DAC2=yes

#specify the device path
CXSNDDEV="hw:0"

#disable Headphone amp for lineout routing.
amixer -D$CXSNDDEV cset name='PortA HP Amp Switch' off
#enable Headphone amp for headphone routing.
amixer -D$CXSNDDEV cset name='PortA HP Amp Switch' on

echo "XX:$USING_DAC2"
if [ $USING_DAC2 = "yes" ] ; then # HP through DAC2
	echo "HP port go through DAC2, bypass DSP effect"
	amixer -D$CXSNDDEV cset name='PortA Mux' 1
	amixer -D$CXSNDDEV cset name='I2S DAC1L Switch' off
	amixer -D$CXSNDDEV cset name='I2S DAC1R Switch' off
	amixer -D$CXSNDDEV cset name='I2S DAC2L Switch' on
	amixer -D$CXSNDDEV cset name='I2S DAC2R Switch' on
	amixer -D$CXSNDDEV cset name='PortG Out En Switch' off

else
	echo "HP port go through DAC1"
	amixer -D$CXSNDDEV cset name='PortA Mux' 0
	amixer -D$CXSNDDEV cset name='I2S DAC2L Switch' off
	amixer -D$CXSNDDEV cset name='I2S DAC2R Switch' off
	amixer -D$CXSNDDEV cset name='I2S DAC1L Switch' on
	amixer -D$CXSNDDEV cset name='I2S DAC1R Switch' on
	amixer -D$CXSNDDEV cset name='PortG Out En Switch' off

##### add DSP setting below #####

fi
