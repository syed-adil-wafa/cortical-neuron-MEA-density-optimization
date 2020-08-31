## Optimizing density of human induced pluripotent stem cell-derived cortical neurons for multi-electrode array recordings


### Summary
The electrophysiological properties of neuronal networks are increasingly being characterized by multi-electrode arrays ([Wainger *et al.*, 2014](https://www.ncbi.nlm.nih.gov/pubmed/24703839); [Cleber *et al.*, 2019](https://www.ncbi.nlm.nih.gov/pubmed/31474560); [Winden *et al.*, 2019](https://www.ncbi.nlm.nih.gov/pubmed/31591157)). While higher cell seeding densities could reveal more rich functional information relative to lower cell seeding densities, the former might not be as cost-effective as the latter for large-scale studies. In this experiment, we compared the firing, bursting, network bursting, and synchrony activity of human induced pluripotent stem cell (iPSC)-derived excitatory glutamatergic NGN2 cortical neurons seeded at three different cell densities (100,000, 150,000, and 200,000 neurons per well) on multi-electrode array plates. While there were no large differences in the firing rates between the three cell densities, wells plated with 100,000 neurons displayed the greatest inter-spike interval (ISI) coefficient of variation, greatest number of spikes per burst and per network burst, greatest variance in the number of spikes per burst and per network burst, least ISI per burst, and greatest synchrony; therefore, while this seeding density group was the most synchronous, they displayed the most irregular firing, bursting, and network bursting.

### Methods
All experiments were conducted after receiving institutional review board approval. iPSCs were generated from patient fibroblasts and excitatory glutamatergic NGN2 cortical neuron differentiations were performed as described in [Zhang *et al.* (2013)](https://www.ncbi.nlm.nih.gov/pubmed/23764284). Neurons were plated on poly-D-lysine/laminin coated 48-well multi-electrode array plates. Recordings from 16 extracellular electrodes in each well were made using a Maestro (Axion BioSystems) multi-electrode array recording amplifier with a head stage that maintained a temperature of 37 &deg;C. 
#### Spike, burst, and network burst detection
Data were sampled at 12.5 kHz, digitized, and analyzed using Axion Integrated Studio software (Axion BioSystems) with 200 Hz high-pass and 3 kHz low-pass Butterworth filters. Spikes were detected using an adaptive spike detection threshold set at 6 times the standard deviation for each electrode with 0.84 ms and 2.16 ms pre- and post-spike durations and non-overlapping 1 s binning. Bursts were detected using an ISI threshold with minimum 5 spikes and maximum 100 ms ISI. Network bursts were detected with minimum 10 spikes and maximum 100 ms ISI with 25% of electrodes participating. Synchrony metrics between electrodes were computed within 20 ms windows.
#### Data analysis
Downstream data analysis was performed using in-house scripts written in MATLAB 2019b (The MathWorks, Inc.).

### Results and discussion
While there were no large differences in the firing rates between the three groups, wells plated with 100,000 neurons displayed the greatest ISI coefficient of variation suggesting irregularity in firing. The following figure compares the firing activity at the different cell densities.
![alt text](https://github.com/syed-adil-wafa/cortical-neuron-MEA-density-optimization/blob/master/figures/firing%20features.png)
There were no differences in the number of bursts between the three groups. While wells plated with 100,000 neurons displayed the greatest number of spikes per burst, they also displayed the greatest deviation in the number of spikes per burst suggesting irregularity in bursting. The following figure compares the bursting activity at the different cell densities.
![alt text](https://github.com/syed-adil-wafa/cortical-neuron-MEA-density-optimization/blob/master/figures/bursting%20features.png)
While wells plated with 100,000 neurons displayed the lowest number of network bursts. However, they displayed the greatest number of spikes per network burst and also the greatest deviation in the number of spikes per network burst suggesting irregularity in network bursting. The following figure compares the network bursting activity at the different cell densities.
![alt text](https://github.com/syed-adil-wafa/cortical-neuron-MEA-density-optimization/blob/master/figures/network%20bursting%20features.png)
Comparing the synchrony index and the area under normalized cross-correlation indicates wells plated with 100,000 neurons to be the most synchronous.
![alt text](https://github.com/syed-adil-wafa/cortical-neuron-MEA-density-optimization/blob/master/figures/synchrony%20features.png)

### Acknowledgements
Human Neuron Core: http://www.childrenshospital.org/research/labs/human-neuron-core
<br/> Laboratory of Mustafa Sahin: http://sahin-lab.org/
<br/> Harvard Stem Cell Institute: https://hsci.harvard.edu/
<br/> Laboratory of Thomas S&uuml;dhof: https://med.stanford.edu/sudhoflab.html

### References
Zhang, Y., Pak, C., Han, Y., Ahlenius, H., Zhang, Z., Chanda, S., Marro, S., Patzke, C., Acuna, C., Covy, J., Xu, W., Yang, N., Danko, T., Chen, L., Wenig, M., & Sudhof, T.C. (2013). Rapid Single-Step Induction of Functional Neurons from Human Pluripotent Stem Cells. *Neuron*, *78*(5), 785-798. DOI: [10.1016/j.neuron.2013.05.029](https://www.ncbi.nlm.nih.gov/pubmed/23764284)
<br/>
<br/> Wainger, B.J., Kiskinis, E., Mellin, C., Wiskow, O., Han, S.S.W., Sandoe, J., Perez, N.P., Williams, L.A., Lee, S., Boulting, G., Berry, J.D., Brown, Jr., R.H., Cudkowicz, M.E., Bean, B.P., Eggan, K., & Woolf, C.J. (2014). Intrinsic Membrane Hyperexcitability of Amyotrophic Lateral Sclerosis Patient-Derived Motor Neurons. *Cell Reports*, *7*(1), 1-11. DOI: [10.1016/j.celrep.2014.03.019](https://www.ncbi.nlm.nih.gov/pubmed/24703839)
<br/>
<br/> Trujillo, C.A., Gao, R., Negraes, P.D., Gu, J., Buchanan, J., Preissl, S., Wang, A., Wu, W., Haddad, G.G., Chaim, I.A., Domissy, A., Vandenberghe, M., Devor, A., Yeo, G.W., Voytek, B., & Muotri, A.R. (2019). Complex Oscillatory Waves Emerging from Cortical Organoids Model Early Human Brain Network Development. *Cell Stem Cell*, *25*(4), 558-569. DOI: [10.1016/j.stem.2019.08.002](https://www.ncbi.nlm.nih.gov/pubmed/31474560)
<br/>
<br/> Winden, K.D., Sundberg, M., Yang, C., Wafa, S.M.A., Dwyer, S., Chen, P.-F., Buttermore, E.D., & Sahin, M. (2019). Biallelic mutations in *TSC2* lead to abnormalities associated with cortical tubers in human iPSC-derived neurons. *The Journal of Neuroscience*, *39*(47), 9294-9305. DOI: [https://doi.org/10.1523/JNEUROSCI.0642-19.2019](https://www.ncbi.nlm.nih.gov/pubmed/31591157) 
