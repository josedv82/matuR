
#' Maturation and Biobanding Metrics
#'
#' This function returns a dataframe wih computed maturation metrics in cms calculated from the raw data imported by the user. See references for further details about the methodology behind each metric.
#' For the same table in Inches see `maturation_in()`
#'
#' @param data A data frame. See data_sample for formatting reference.
#' @return A data frame with the following columns:
#'  \describe{
#'          \item{Athlete}{A chracter string. The name of the athlete}
#'          \item{Gender}{A character String. The gender of the athlete}
#'          \item{`Testing Date`}{A date. The data collection date for each athlete}
#'          \item{`Birth Year`}{The year of birth for every athlete}
#'          \item{Quarter}{The yearly quarter in which athletes were born}
#'          \item{`Height (CM)`}{The height in cms for each athlete at the time of testing}
#'          \item{`Estimated Adult Height (CM)`}{The estimated adult height in cms of the athlete using the Khamis-Roche method. See references for further details.}
#'          \item{`% Adult Height`}{Their current height expressed as %, compared to their predicted adult height}
#'          \item{`Remaining Growth (CM)`}{The difference between their predicted adult height and current height, in cms}
#'          \item{`Maturity Offset (years)`}{Difference between their current age and their estimated age at PHV, espressed in years.}
#'          \item{`Age @ PHV`}{The estimated age of the player at the time of Peak Height Velocity. Calculated using the Mirwald equation. See references for further details.}
#'          \item{`Maturity Category`}{Categries for bio-banding based on the work from Cumming et al, 2017. See references for further details.}
#'     }
#'
#'
#' @references
#'     - Khamis, H. J., & Roche, A. F, 1994. Predicting adult height without using skeletal age: The Khamis-Roche method. Pediatrics, 94, 504–507
#'     - Sean P. Cumming, Rhodri S. Lloyd, John L. Oliver, Joey C. Eisenmann & Robert M. Malina, 2017. Bio-banding in Sport: Applications to competition, talent identification and strength and conditioning of youth athletes, National Strength and Conditioning Association, vol.39, 2
#'     - Mirwald, R.L., Baxter-Jones, A.D.G., Bailey, D.A., & Beunen, G.P., 2002. An assessment of maturity from anthropometric measurements. Medicine and Science Sports Exercise, 34,4, pp. 689–694.
#'     - Johnson DM, Williams S, Bradley B, Sayer S, Fisher JM. Growing pains : Maturity associated variation in injury risk in academy football. Eur J Sport Sci . 2019:1–9.
#'
#' @export
#' @examples
#' maturation_cm(data_sample)
#'

maturation_cm <- function(data) {

  final_table <- data %>%
    dplyr::mutate(Age = round((lubridate::time_length(difftime(as.Date(`Testing Date`), as.Date(`Date of Birth`)), "years")/0.5)) * 0.5) %>%
    dplyr::mutate(`Testing Date` = as.Date(`Testing Date`)) %>%
    dplyr::mutate(`Date of Birth` = as.Date(`Date of Birth`)) %>%
    dplyr::mutate(`Birth Year` = lubridate::year(`Date of Birth`)) %>%
    dplyr::mutate(Quarter = paste("Q", lubridate::quarter(`Date of Birth`), sep = "")) %>%
    dplyr::mutate(`Weight (KG)` = round((`Weight1 (KG)` + `Weight2 (KG)`) / 2, 1),
           `Weight (LB)` = round(`Weight (KG)` * 2.20462),
           `Height (CM)` = round((`Height1 (CM)` + `Height2 (CM)`) / 2, 1),
           `Height (IN)` = round(`Height (CM)` * 0.393701,1),
           `Sitting Height (CM)` = ((`Sitting Height1 (CM)` + `Sitting Height2 (CM)`) / 2) - `Bench Height (CM)`,
           `Leg Length (CM)` = `Height (CM)` - `Sitting Height (CM)`) %>%
    dplyr::mutate(`H-W Ratio` = round(`Height (CM)` / (`Weight (KG)`^ 0.33333),1),
           `W-H Ratio` = round((`Weight (KG)` / `Height (CM)`) * 100,1),
           BMI = round((`Weight (KG)` / (`Height (CM)`/100) ^ 2),1),
           `Sitting/Stand Height` = round(`Sitting Height (CM)` / `Height (CM)`,1),
           `Leg Length * Sitting Height` =  round(`Leg Length (CM)` * `Sitting Height (CM)`,1),
           `Age * Leg Length` = `Leg Length (CM)` * Age,
           `Age * Sitting Height` = `Sitting Height (CM)` * Age,
           `Age * Weight` = `Weight (KG)` * Age) %>%
    dplyr::mutate(`Parent Mid Height (CM)` = round((`Mothers Height (CM)` + `Fathers Height (CM)`) / 2, 1)) %>%
    dplyr::mutate(`Parent Mid Height (IN)` = `Parent Mid Height (CM)` * 0.393701) %>%
    dplyr::full_join(matuR::table, by = c("Age" = "Age")) %>%
    na.omit() %>%
    dplyr::mutate(`Estimated Adult Height (IN)` = ifelse(Gender == "Male", round(`B1` + (`Height (IN)` * `M-Height`) + (`Weight (LB)` * `M-Weight`) + (`Parent Mid Height (IN)` * `M-Midparent Stature`),1), round(`B2` + (`Height (IN)` * `F-Height`) + (`Weight (LB)` * `F-Weight`) + (`Parent Mid Height (IN)` * `F-Midparent Stature`),1))) %>%
    dplyr::mutate(`Estimated Adult Height (CM)` = round(`Estimated Adult Height (IN)` * 2.54,1)) %>%
    dplyr::mutate(`% Adult Height` = round((`Height (CM)` / `Estimated Adult Height (CM)`) * 100,1)) %>%
    dplyr::mutate(`Remaining Growth (CM)` = round((`Estimated Adult Height (CM)` - `Height (CM)`),1)) %>%
    dplyr::mutate(`Remaining Growth (IN)` = round(`Remaining Growth (CM)` * 0.393701,1)) %>%
    dplyr::mutate(`Maturity Offset (years)` = ifelse(Gender == "Male", round(-9.236 + (0.0002728 * (`Leg Length * Sitting Height`)) + (-0.001663 * `Age * Leg Length`) + (0.007216 * `Age * Sitting Height`) + (0.02292 * `W-H Ratio`),1), round(-9.376 + (0.0001882 * (`Leg Length * Sitting Height`)) + (0.0022 * `Age * Leg Length`) + (0.005841 * `Age * Sitting Height`) + (-0.002658 * `Age * Weight`) + (0.07693 * `W-H Ratio`),1))) %>%
    dplyr::mutate(`Age @ PHV` = Age - `Maturity Offset (years)`) %>%
    dplyr::select(Athlete, Gender, `Testing Date`, `Birth Year`, Quarter, Age, `Height (CM)`, `Estimated Adult Height (CM)`, `% Adult Height`, `Remaining Growth (CM)`, `Maturity Offset (years)`, `Age @ PHV`) %>%
    dplyr::mutate(`Maturity Category` = ifelse(`% Adult Height` < 85, "Pre-Pubertal",
                                        ifelse(`% Adult Height` >= 85 & `% Adult Height` < 90, "Early Pubertal",
                                               ifelse(`% Adult Height` >= 90 & `% Adult Height` < 95, "Mid-Pubertal", "Late Pubertal"))))

  return(final_table)

}
