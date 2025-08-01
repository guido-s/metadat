context("Checking: dat.law1994")

library(digest)

test_that("md5 hash matches for the data", {
   expect_match(digest(metadat::dat.law1994, algo="md5"), "b0e3e3b83e39657c124703cab4ae1173")
})
