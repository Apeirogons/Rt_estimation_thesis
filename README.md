# COVID-math-thesis
Repository for code relating to my HTHSCI 4R09 thesis project, related to epidemic timeseries.

epidemic_timeseries contains all the mobility PCA, timeseries clustering, and phase planes. It's ready to run: Linux users should just type $make, and if you can't do that, just download the appropriate files (link in the Makefile) and run all the python scripts.

shifts contains code for the R(t) estimation idea. To run the code, run estimate.R, estimate_2.R, and estimate_renewal.R. The Wallinga-Tenuis estimation method is VERY slow, so this should take a while.

lag_estimation_revisited revisits an old idea of determining the time lag distribution by finding convolutions that plausibly explained the distance between two curves. To run the code, download the province data from https://github.com/ishaberry/Covid19Canada and copy them into a new folder: lag_estimation_revisited/data/timeseries_prov, run shifts/estimate_2.R, and run the two .py files in lag_estimation_revisited. I may update the makefile for this next week, depending on whether or not we intend on revisiting this.

time_lag_old contains depreciated code. One idea was to use publicly available patient-level data to come up with key epidemiological lags, which seemed like an okay approach.
