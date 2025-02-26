
# **Mendelian Randomization LD Clumping Using PLINK & TwoSampleMR**  

## **Overview**  
This repository contains an **R script** that performs **LD clumping** on **GWAS summary statistics** for **Mendelian Randomization (MR)** studies. The script utilizes **PLINK** and the **TwoSampleMR package** to filter and clump **single nucleotide polymorphisms (SNPs)** across multiple populations (**EUR, AFR, AMR, EAS, SAS**).  

This pipeline is useful for researchers conducting **genome-wide association studies (GWAS)**, **causal inference analysis**, **genetic epidemiology**, and **multi-omics analysis**.  

## **Features**  
✅ **Automated LD Clumping** using **PLINK** and **TwoSampleMR**  
✅ **Supports Multiple Ancestries** (EUR, AFR, AMR, EAS, SAS)  
✅ **Processes Multiple GWAS Files** in One Go  
✅ **Efficient Data Handling** with `data.table`, `dplyr`, and `tibble`  
✅ **Optimized for Large-Scale GWAS Summary Statistics**  

## **Installation & Requirements**  

### **1. Install Required R Packages**  
Ensure you have the following R packages installed:  

```r
install.packages(c("remotes", "data.table", "tibble", "dplyr", "ieugwasr"))
remotes::install_github("MRCIEU/TwoSampleMR")
```

### **2. Install PLINK**  
Download and install **PLINK 1.9** from [PLINK's official website](https://www.cog-genomics.org/plink/).  

### **3. Set Up LD Reference Panel**  
The script requires **LD reference panel files (.bed, .bim, .fam)** for different populations (e.g., EUR, AFR, AMR, EAS, SAS). You can download reference data from:  
- [1000 Genomes Project](https://www.internationalgenome.org/) 

## **Usage**  

### **1. Modify the Paths in the Script**  
Update the following variables in the script:  
- **`exposure_dir_path`** → Path to your **GWAS summary statistics**  
- **`output_dir`** → Path to save **clumped SNPs**  
- **`plink_path`** → Path to the **PLINK executable**  
- **LD reference panel paths** (`bfile` argument in `ld_clump()`)  

### **2. Run the Script**  
After setting up, run the script in **R**:  

```r
source("your_script.R")
```

The script will:  
✔ Read and format **GWAS summary statistics**  
✔ Perform **LD clumping** for multiple populations  
✔ Save **clumped SNPs** to the specified output directory  

## **Output Format**  
The script generates `.csv` files containing **clumped SNPs** for each input GWAS dataset:  
```
final_clumped_snps_<filename>.csv
```
Each file contains **LD-independent SNPs** filtered based on `clump_kb = 1000` and `clump_r2 = 0.02`.  

## **Citation & References**  
If you use this pipeline, please cite:  
- **PLINK:** Purcell et al. (2007) *PLINK: A Toolset for Whole-Genome Association and Population-Based Linkage Analyses*.  
- **TwoSampleMR:** Hemani et al. (2018) *The MR-Base platform supports systematic causal inference across the human phenome.*  

## **Keywords**  
*Mendelian Randomization, LD Clumping, PLINK, GWAS, TwoSampleMR, SNP Clumping, Genetic Association Studies, Bioinformatics, Causal Inference, Multi-Omics, Genome-Wide Analysis, R Script for GWAS, MR-Base, 1000 Genomes Project* 


## **REFERENCES**

1. https://cloufield.github.io/GWASTutorial/16_mendelian_randomization/
2. https://github.com/MRCIEU/TwoSampleMR/tree/master
3. https://api.opengwas.io/?next=%2Fprofile%2F
4. https://www.internationalgenome.org/
5. https://www.cog-genomics.org/plink/
6. https://andrewslabucsf.github.io/MR-tutorial/scripts/mr.html
