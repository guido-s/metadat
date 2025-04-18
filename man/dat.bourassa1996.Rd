\name{dat.bourassa1996}
\docType{data}
\alias{dat.bourassa1996}
\title{Studies on the Association between Handedness and Eye-Dominance}
\description{Results from 47 studies on the association between handedness and eye-dominance. \loadmathjax}
\usage{
dat.bourassa1996
}
\format{
The data frame contains the following columns:
\tabular{lll}{
\bold{study}        \tab \code{numeric}   \tab study number \cr
\bold{sample}       \tab \code{numeric}   \tab sample number \cr
\bold{author}       \tab \code{character} \tab (first) author \cr
\bold{year}         \tab \code{numeric}   \tab publication year \cr
\bold{selection}    \tab \code{character} \tab selection of subjects on the basis of eyedness or handedness \cr
\bold{investigator} \tab \code{character} \tab investigator (psychologist, educationalist, or other) \cr
\bold{hand_assess}  \tab \code{character} \tab method to assess handedness (questionnaire or performance based) \cr
\bold{eye_assess}   \tab \code{character} \tab method to assess eyedness (see \sQuote{Details}) \cr
\bold{mage}         \tab \code{numeric}   \tab mean age of sample \cr
\bold{lh.le}        \tab \code{numeric}   \tab number of left-handed left-eyed individuals \cr
\bold{lh.re}        \tab \code{numeric}   \tab number of left-handed right-eyed individuals \cr
\bold{rh.le}        \tab \code{numeric}   \tab number of right-handed left-eyed individuals \cr
\bold{rh.re}        \tab \code{numeric}   \tab number of right-handed right-eyed individuals \cr
\bold{sex}          \tab \code{character} \tab sex of the sample (combined, male, or female)
}
}
\details{
   The 47 studies included in this meta-analysis examined the association between handedness and eye-dominance (ocular dominance or eyedness). Results are given in terms of \mjeqn{2 \times 2}{2x2} tables, indicating the number of left-handed left-eyed, left-handed right-eyed, right-handed left-eyed, and right-handed right-eyed individuals in each sample. Note that some studies included multiple (independent) samples, so that the meta-analysis included 54 samples in total. Also, for some studies, the combined data of the males and females are further broken down into the two subgroups.

   In some studies, there was indication that the selection of subjects was not random with respect to handedness and/or eyedness. While this should not influence the size of the association as measured with the odds ratio, this invalidates those studies for assessing the overall percentage of left-eyed and left-handed individuals.

   Handedness was assessed in the individual studies either based on a questionnaire or based on task performance. Eyedness was assessed based on various methods: \code{E.1} methods are based on task performance, while \code{E.2.a} denotes assessment based on a questionnaire. The performance based methods could be further broken down into: \code{E.1.a.i} (monocular procedure with object/instrument held in one hand), \code{E.1.a.ii} (monocular procedure with object/instrument held in both hands), \code{E.1.b} (binocular procedure), \code{E.1.c} (a combination of the previous methods), and \code{E.1.d} (some other method).
}
\source{
   Bourassa, D. C., McManus, I. C., & Bryden, M. P. (1996). Handedness and eye-dominance: A meta-analysis of their relationship. \emph{Laterality}, \bold{1}(1), 5--34. \verb{https://doi.org/10.1080/713754206}
}
\author{
   Wolfgang Viechtbauer, \email{wvb@metafor-project.org}, \url{https://www.metafor-project.org}
}
\examples{
### copy data into 'dat' and examine data
dat <- dat.bourassa1996
head(dat, 10)

\dontrun{
### load metafor package
library(metafor)

### calculate log(OR) and corresponding sampling variance with 1/2 correction
dat <- escalc(measure="OR", ai=lh.le, bi=lh.re, ci=rh.le, di=rh.re, data=dat, add=1/2, to="all")
head(dat, 10)

### overall association between handedness and eyedness
res <- rma(yi, vi, data=dat, subset=sex=="combined")
res
predict(res, transf=exp, digits=2)

### multilevel model to account for heterogeneity at the study and sample levels
res <- rma.mv(yi, vi, random = ~ 1 | study/sample, data=dat, subset=sex=="combined")
res
predict(res, transf=exp, digits=2)

### restructure the dataset to keep only the male/female data when it is reported
### separately and the combined data when this is the only data reported
dat <- lapply(split(dat, dat$sample), function(x) {
   if (nrow(x) == 3L) {
      x[-which(x$sex == "combined"),]
   } else {
      x
   }
})
dat <- do.call(rbind, dat)
rownames(dat) <- NULL
dat

### multilevel model to account for heterogeneity at the study, sample, and subgroup levels
res <- rma.mv(yi, vi, random = ~ 1 | study/sample/sex, data=dat)
res
predict(res, transf=exp, digits=2)
}
}
\keyword{datasets}
\concept{psychology}
\concept{odds ratios}
\concept{multilevel models}
\section{Concepts}{
   psychology, odds ratios, multilevel models
}
