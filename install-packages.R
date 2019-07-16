library(BiocManager)

options(repos = c(CRAN = "file:///home/tracer/mirrors/cran"),
        BioC_mirror = "file:///home/tracer/mirrors/bioconductor")

ncpus <- as.integer(system2("nproc", stdout = TRUE, stderr = TRUE))

cat("Installing packages with", ncpus, "cpus\n")

install(available(),
        Ncpus = 12,
        keep_outputs = TRUE,
        INSTALL_opts = c(## byte-compile packages
                         ##"--byte-compile",
                         ## extract and keep examples
                         "--example",
                         ## copy and retain test directory for the package
                         "--install-tests",
                         ## keep line numbers
                         "--with-keep.source",
                         "--no-multiarch"),
        dependencies = c("Depends", "Imports", "LinkingTo", "Suggests", "Enhances"))
