#! /usr/bin/Rscript
library('ggplot2')
library('EpiEstim')
library('ggthemes')
library('data.table')
library('extraDistr')
library('poweRlaw')
library('zoo')
source('ts_utils/process_utils.R')


##################################################################################
# Simulation parameters
t = c(0:401)



##################################################################################
# Periodic detection parameters
detection_prob = 0.8
detection_consts = c(1, 1.05, 1.05, 1, 1, 1, 1)

# Incubation/Infection/Detection distribution parameters
# https://jamanetwork.com/journals/jamanetworkopen/fullarticle/2774707
indices = c(0:50)

# Real-world incubation period (E->I distribution)
inc = dislnorm$new()
inc$setPars(c(1.63, 0.5))

# Infectious period = recovery time
#https://www.ncbi.nlm.nih.gov/pmc/articles/PMC7409948/
inf = disexp$new()
inf$setPars(c(1/13))


#inf= dislnorm$new()
#inf$setPars(c(1.56, 0.5))#2.56
#inf$setXmin(0)
#plot(dist_pdf(inf, q=indices))


# Detection distribution
det = dislnorm$new()
det$setPars(c(1.7, 0.5))


#####################################################################################################
# Parse parameters

inc$setXmin(0)
incubation_pdf = dist_pdf(inc, q=indices)
incubation_pdf = incubation_pdf/sum(incubation_pdf)

inf$setXmin(0)
infectious_pdf = dist_pdf(inf, q=indices)
infectious_pdf = infectious_pdf/sum(infectious_pdf)

det$setXmin(0)
detection_pdf = dist_pdf(det, q=indices)
detection_pdf = detection_pdf/sum(detection_pdf)

temp = get_detection_pdfs(detection_prob, detection_consts, infectious_pdf, incubation_pdf, detection_pdf)
periodized_detections = temp$periodized_detections
p_greaters = temp$p_greaters
cumulative_time_to_recovery = temp$cumulative_time_to_recovery
generation_int = convolve(incubation_pdf, rev(infectious_pdf), type='open')
generation_int[generation_int<0] = 0

#df = data.frame(t=indices, incubation=incubation_pdf, infectious = infectious_pdf)
#write.csv(df, 'incubation_and_infectious.csv')
mean_generation = sum(c(0:(length(generation_int)-1))*generation_int)
mean_infectious = sum(c(0:(length(infectious_pdf)-1))*infectious_pdf)
mean_detection = sum(c(0:(length(detection_pdf)-1))*detection_pdf)


