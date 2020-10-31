#' Predicted Height Plot (cms)
#'
#' This function returns a ggplot object showing the predicted adult height for each athlete in the dataset.
#' For the same plot in inches use **`plot_predicted_height_in()`**
#'
#' @param data A data frame. The object containing the raw data we wish to analize.
#' @return A plot `(ggplot)`
#'
#' @export
#' @examples
#' plot_predicted_height_cm(data_sample)
#'

plot_predicted_height_cm <- function(data) {

  dat <- maturation_cm(data) %>%
    dplyr::mutate(`Error (CM)` = ifelse(Gender == "Male", (2.1 * 2.54) / 2, (1.7 * 2.54) / 2))

  plot <- ggplot2::ggplot(data = dat, ggplot2::aes(x = `Estimated Adult Height (CM)`, y = reorder(Athlete, `Estimated Adult Height (CM)`))) +
    ggplot2::geom_pointrange(ggplot2::aes(xmin = `Estimated Adult Height (CM)` - `Error (CM)`, xmax = `Estimated Adult Height (CM)` + `Error (CM)`)) +
    ggplot2::facet_wrap(~Gender, scales = "free_y") +
    ggplot2::scale_x_continuous(breaks = seq(0, 300, by = 5)) +
    ggplot2::ylab("") + ggplot2::xlab("\n Centimeters") +
    ggplot2::ggtitle("\n Estimated Adult Height (CM) \n") +
    ggplot2::theme_light() +
    ggplot2::theme(axis.title.x = ggplot2::element_text(color = "grey", hjust = 1),
          panel.grid.minor = ggplot2::element_blank(),
          panel.grid.major = ggplot2::element_line(linetype = 2),
          strip.background = ggplot2::element_rect(fill = "black"),
          panel.spacing = ggplot2::unit(2, "lines"))

  plot

}


