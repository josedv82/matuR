#' Khamis-Roche model estimates tables
#'
#' @details
#' A data frame containing model estimates and predictions by age from the Khamis-Roche method.
#'
#' For further details visit \url{https://pediatrics.aappublications.org/content/94/4/504.short}
#'
#' @format Data frame with 13 variables and 20 observations:
#' \describe{
#'    \item{Age}{Age group in years. Rounded every 6 months.}
#'    \item{B1}{Model intercept for males.}
#'    \item{M-Height}{Height (inches), for males.}
#'    \item{M-Weight}{Weight (lbs) for males.}
#'    \item{`M-Midparent Stature`}{Average estature across mather & father for each age group, for males.}
#'    \item{B2}{Model intercept for females.}
#'    \item{F-Height}{Height (inches), for females.}
#'    \item{F-Weight}{Weight (lbs) for males.}
#'    \item{`F-Midparent Stature`}{Average estature across mather & father for each age group, for females.}
#'
#'
#' }
#' @usage table
#'

"table"
