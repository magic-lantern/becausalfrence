# ICD 9 to ICD 10 mapping (and vice versa)
# Where to get the mapping files from:
# https://www.cms.gov/Medicare/Coding/ICD10/Downloads/2018-ICD-10-CM-General-Equivalence-Mappings.zip
# https://www.cms.gov/Medicare/Coding/ICD10/Downloads/2018-ICD-10-PCS-General-Equivalence-Mappings.zip
#
# Download files and save to ./data/, then unzip
# these next lines should download and extract, but if there is a problem, try manually downloading from the CMS website
download.file('https://www.cms.gov/Medicare/Coding/ICD10/Downloads/2018-ICD-10-CM-General-Equivalence-Mappings.zip', './data/2018-ICD-10-CM-General-Equivalence-Mappings.zip')
untar('./data/2018-ICD-10-CM-General-Equivalence-Mappings.zip', exdir='./data/2018-ICD-10-CM-General-Equivalence-Mappings')
download.file('https://www.cms.gov/Medicare/Coding/ICD10/Downloads/2018-ICD-10-PCS-General-Equivalence-Mappings.zip', './data/2018-ICD-10-PCS-General-Equivalence-Mappings.zip')
untar('./data/2018-ICD-10-PCS-General-Equivalence-Mappings.zip', exdir='./data/2018-ICD-10-PCS-General-Equivalence-Mappings')

# ICD 10 CM (Diagnosis codes) to ICD 9
library(data.table)
mapper <- fread(file = './data/2018-ICD-10-CM-General-Equivalence-Mappings/2018_I9gem.txt',
                col.names = c('icd9', 'icd10', 'flags'),
                colClasses = c("character"))
  
search_for_icd9 = function(icd10_search_term) {
  t <- gsub("[. ]", "", icd10_search_term)
  mapper[icd10 %in% t]
}

# convert list of ICD10CM codes to ICD9 Codes
icd9s <- search_for_icd9(c('A02.1','A20.7','A22.7','A26.7','A32.7','A39.2','A39.3','A39.4','A40.0','A40.1',
                           'A40.3','A40.8','A40.9','A41.01','A41.02','A41.1','A41.2','A41.3','A41.4','A41.50',
                           'A41.51','A41.52','A41.53','A41.59','A41.81','A41.89','A41.9','A42.7','A48.3','A54.86',
                           'B00.7','B37.7','P36.0','P36.10','P36.19','P36.2','P36.30','P36.39','P36.4','P36.5',
                           'P36.8','P36.9','R57.1','R57.8','R65.10','R65.11','R65.20','R65.21','T81.12XA'))[, icd9]

