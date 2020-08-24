## Optimizing density of stem cell-derived cortical neurons for multi-electrode array recordings


### Summary
The electrophysiological properties of neuronal networks are increasingly being characterized by multi-electrode arrays ([Wainger *et al.*, 2014](https://www.ncbi.nlm.nih.gov/pubmed/24703839); [Cleber *et al.*, 2019](https://www.ncbi.nlm.nih.gov/pubmed/31474560); [Winden *et al.*, 2019](https://www.ncbi.nlm.nih.gov/pubmed/31591157)). While higher cell seeding densities could reveal more rich functional information relative to lower cell seeding densities, the former might not be as cost-effective as the latter for large-scale studies. In this experiment, we compared the activity of human induced pluripotent stem cell (iPSC)-derived excitatory cortical glutamatergic neurons seeded at three different cell densities (100,000, 150,000, and 200,000 neurons per well) on multi-electrode array plates. We did not observe large differences in spiking rates between the three cell densities. To discover electrophysiological features that distinguish the three groups, we developed a machine learning algorithm and visualized the relative feature importance in classification. The model revealed features, such as synchrony between electrodes, mean inter-spike interval (ISI) per burst, and ISI coefficient of variation, to be better predictors of distingushing the three groups at later culture time-points. Specifically, wells plated with 100,000 neurons displayed greater synchrony, reduced ISI per burst, and a larger ISI coefficient of variation; therefore, while this seeding density group was the most synchronous, they displayed the most irregular firing.

### Methods
All experiments were conducted after receiving institutional review board approval. iPSCs were generated from patient fibroblasts and cortical neuron differentiations were performed as described in [Zhang *et al.* (2013)](https://www.ncbi.nlm.nih.gov/pubmed/23764284). Neurons were plated on poly-D-lysine/laminin coated 48-well multi-electrode array plates. Recordings from 16 extracellular electrodes in each well were made using a Maestro (Axion BioSystems) multi-electrode array recording amplifier with a head stage that maintained a temperature of 37&deg;C. 
#### Spike, burst, and network burst detection
Data were sampled at 12.5 kHz, digitized, and analyzed using Axion Integrated Studio software (Axion BioSystems) with 200 Hz high-pass and 3 kHz low-pass Butterworth filters. Spikes were detected using an adaptive spike detection threshold set at 6 times the standard deviation for each electrode with 0.84 ms and 2.16 ms pre- and post-spike durations and non-overlapping 1 s binning. Bursts were detected using an ISI threshold with minimum 5 spikes and maximum 100 ms ISI. Network bursts were detected with minimum 10 spikes and maximum 100 ms ISI with 25% of electrodes participating. Synchrony metrics between electrodes were computed within 20 ms windows.
#### Data analysis
Downstream data analysis was conducted using in-house scripts written in MATLAB 2019b (The MathWorks, Inc.).

### Results and discussion
We first observed that there was not a large difference in the spiking rates between the three cell density groups.
![alt text](https://github.com/syed-adil-wafa/cortical-neuron-MEA-density-optimization/blob/master/figures/figure_1.png)

To screen different electrophysiological features, we built a non-linear machine learning algorithm (ensemble model of decision trees) to classify the three groups of cell densities. Decision trees classify groups through a series of binary questions, such that each question only has two possible responses ('yes' or 'no'). They start at the top question (also called 'root node') and travel along tree branches as guided by responses until a terminal leaf node is reached, which indicates the predicted class. The number of times a feature is used within each decision tree determines its relative importance in classification. Feature importance in classifying the three groups was visualized using a clustergram.
![alt text](https://github.com/syed-adil-wafa/cortical-neuron-MEA-density-optimization/blob/master/figures/figure_2.png)

The machine learning model suggested that the three groups could be distinguished using other electrophysiological features, such as synchrony, mean ISI per burst, and ISI coefficient of variation, particularly during later culture time-points. A more detailed analysis suggested that wells plated with 100,000 neurons displayed greater synchrony, reduced ISI per burst, and a larger ISI coefficient of variation, relative to the other densities. Therefore, while this cell density group was the most synchronous, they displayed the most irregular firing.
![alt text](https://github.com/syed-adil-wafa/cortical-neuron-MEA-density-optimization/blob/master/figures/figure_3.png)
![alt text](https://github.com/syed-adil-wafa/cortical-neuron-MEA-density-optimization/blob/master/figures/figure_4.png)
![alt text](https://github.com/syed-adil-wafa/cortical-neuron-MEA-density-optimization/blob/master/figures/figure_5.png)

### Acknowledgements
Human Neuron Core: http://www.childrenshospital.org/research/labs/human-neuron-core
<br/> Laboratory of Mustafa Sahin: http://sahin-lab.org/
<br/> Harvard Stem Cell Institute: https://hsci.harvard.edu/
<br/> Laboratory of Thomas S&uuml;dhof: https://med.stanford.edu/sudhoflab.html

### References
Zhang, Y., Pak, C., Han, Y., Ahlenius, H., Zhang, Z., Chanda, S., Marro, S., Patzke, C., Acuna, C., Covy, J., Xu, W., Yang, N., Danko, T., Chen, L., Wenig, M., & Sudhof, T.C. (2013). Rapid Single-Step Induction of Functional Neurons from Human Pluripotent Stem Cells. *Neuron*, 78(5), 785-798. DOI: [10.1016/j.neuron.2013.05.029](https://www.ncbi.nlm.nih.gov/pubmed/23764284)
<br/>
<br/> Wainger, B.J., Kiskinis, E., Mellin, C., Wiskow, O., Han, S.S.W., Sandoe, J., Perez, N.P., Williams, L.A., Lee, S., Boulting, G., Berry, J.D., Brown, Jr., R.H., Cudkowicz, M.E., Bean, B.P., Eggan, K., & Woolf, C.J. (2014). Intrinsic Membrane Hyperexcitability of Amyotrophic Lateral Sclerosis Patient-Derived Motor Neurons. *Cell Reports*, 7(1), 1-11. DOI: [10.1016/j.celrep.2014.03.019](https://www.ncbi.nlm.nih.gov/pubmed/24703839)
<br/>
<br/> Trujillo, C.A., Gao, R., Negraes, P.D., Gu, J., Buchanan, J., Preissl, S., Wang, A., Wu, W., Haddad, G.G., Chaim, I.A., Domissy, A., Vandenberghe, M., Devor, A., Yeo, G.W., Voytek, B., & Muotri, A.R. (2019). Complex Oscillatory Waves Emerging from Cortical Organoids Model Early Human Brain Network Development. *Cell Stem Cell*, 25(4), 558-569. DOI: [10.1016/j.stem.2019.08.002](https://www.ncbi.nlm.nih.gov/pubmed/31474560)
<br/>
<br/> Winden, K.D., Sundberg, M., Yang, C., Wafa, S.M.A., Dwyer, S., Chen, P.-F., Buttermore, E.D., & Sahin, M. (2019). Biallelic mutations in *TSC2* lead to abnormalities associated with cortical tubers in human iPSC-derived neurons. *The Journal of Neuroscience*, 39(47), 9294-9305. DOI: [https://doi.org/10.1523/JNEUROSCI.0642-19.2019](https://www.ncbi.nlm.nih.gov/pubmed/31591157) 
