#install and load the packages
library(remotes)
#install_github("MRCIEU/TwoSampleMR"),,,, instal if not yet done
library(TwoSampleMR)
library(data.table)
library(tibble)  
library(dplyr)   
library(ieugwasr)

#store all the filepath into a file
exposure_dir_path <- "insert the path/where/all/your/gwas/relevant/summary/stats/are/present"
file_paths <- list.files(exposure_dir_path, full.names = TRUE)
write(file_paths, file = "paths.txt")
z <- readLines("paths.txt")
output_dir <- "specify/the/path/you/want/to/store/your/data/output/i.eclumped/files"
plink_path <- "path/to/your/plink/exe/file  # Path to PLINK executable

for(i in 1:seq_along(z)) #if the seq along gives error remove the line and directly give the number of fiel in the dir
{
  exp_raw <- fread(z[i])
  exp_raw <- as.data.frame(exp_raw)
  
  #formatting the data make sure to tally it with your exposure file
  exp_dat <- format_data(
    exp_raw,
    type = "exposure",
    snp_col = "rsID",             # Matching rsID column
    beta_col = "beta",            # Effect size
    se_col = "SE",                # Standard error
    effect_allele_col = "eff.allele",  # Effect allele
    other_allele_col = "ref.allele",   # Reference allele
    eaf_col = NULL,               # Column 'af' not present in the image, so setting NULL
    pval_col = "P.weightedSumZ"   # P-value
  ) %>% as_tibble()
  
  #renaming the columns in the tibble as the clumping needs specific names of column
  exp_dat <- exp_dat %>% rename(
    rsid = SNP,        # Rename SNP column
    pval = pval.exposure  # Rename P-value column
  )
  #LOCAL LD CLUMPING
  # Perform LD clumping separately for each population with kb and r2 threshold
  clumped_EUR_data <- ld_clump(exp_dat, plink_bin = plink_path, bfile = "path/to/your/.bed.fam/files/of/the/LD_Reference_panel/EUR", clump_kb = 1000, clump_r2 = 0.02)
  clumped_AFR_data <- ld_clump(exp_dat, plink_bin = plink_path, bfile = "path/to/your/.bed.fam/files/of/the/LD_Reference_panel/AFR", clump_kb = 1000, clump_r2 = 0.02)
  clumped_AMR_data <- ld_clump(exp_dat, plink_bin = plink_path, bfile = "path/to/your/.bed.fam/files/of/the/LD_Reference_panel/AMR", clump_kb = 1000, clump_r2 = 0.02)
  clumped_EAS_data <- ld_clump(exp_dat, plink_bin = plink_path, bfile = "path/to/your/.bed.fam/files/of/the/LD_Reference_panel/EAS", clump_kb = 1000, clump_r2 = 0.02)
  clumped_SAS_data <- ld_clump(exp_dat, plink_bin = plink_path, bfile = "path/to/your/.bed.fam/files/of/the/LD_Reference_panel/SAS", clump_kb = 1000, clump_r2 = 0.02)
  
  # Merge all results and remove duplicates based on SNP ID
  clumped_data <- bind_rows(
    clumped_EUR_data,
    clumped_AFR_data,
    clumped_AMR_data,
    clumped_EAS_data,
    clumped_SAS_data
  ) %>% 
    distinct(rsid, .keep_all = TRUE)  # Keep only unique SNPs
  
  #extracting the base name of the files to use it for the output files
  safe_filename <- basename(z[i])
  write.csv(clumped_data, paste0(output_dir, "final_clumped_snps_", safe_filename, ".csv"), row.names = FALSE)
  
  rm(exp_raw, exp_dat, clumped_EUR_data, clumped_AFR_data, clumped_AMR_data, clumped_EAS_data, clumped_SAS_data, clumped_data)  # Removes all objects from the environment
  gc() #clears garbage memory
  
}

print ("all done!!!!!!yayyayayayay!!!!")