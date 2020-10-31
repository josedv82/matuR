#' Maturity Offset Plot
#'
#' This function returns a lollipop ggplot object showing the offset in years from current age to estimated age at PHV for each athlete in the dataset.
#'
#' Refer to references cited on this package for further details on how these metrics are calculated.
#'
#'
#' @param data A data frame. The object containing the raw data we wish to analize.
#' @return A lolliplot plot `(ggplot)`
#'
#' @export
#' @examples
#' plot_maturity_offset(data_sample)
#'

plot_maturity_offset <- function(data) {

  plot <- maturation_cm(data) %>%
    dplyr::select(Athlete, `Maturity Offset (years)`) %>%
    dplyr::mutate(Type = ifelse(`Maturity Offset (years)` > 0, "Past PHV", "Before PHV")) %>%
    ggplot2::ggplot(ggplot2::aes(x = `Maturity Offset (years)`,y = reorder(Athlete, `Maturity Offset (years)`), color = Type)) +
    ggplot2::geom_segment(ggplot2::aes(xend = 0, yend = Athlete), size = 1) +
    ggplot2::geom_vline(ggplot2::aes(xintercept = 0), color = "white") +
    ggplot2::geom_point(size = 3) +
    ggplot2::geom_text(ggplot2::aes(x = 0, y = -0.2, label = "PHV"), color = "grey", size = 3) +
    ggplot2::geom_text(ggplot2::aes(x = 0, y = -1, label = ""), color = "transparent") +
    ggplot2::scale_color_manual(name="Time", values = c("Past PHV" = "deepskyblue3", "Before PHV" = "darkred")) +
    ggplot2::xlim(-4,4) +
    ggplot2::ylab("Athlete \n") + ggplot2::xlab("\n Years") +
    ggplot2::labs(title = "Maturity Offset", subtitle = "Length of time (in years) from PHV \n") +
    ggplot2::theme_light() +
    ggplot2::theme(axis.title.x = ggplot2::element_text(color = "grey", hjust = 1),
          axis.title.y = ggplot2::element_text(color = "grey", hjust = 1),
          plot.subtitle = ggplot2::element_text(color = "darkgray"),
          panel.grid.minor = ggplot2::element_blank(),
          panel.grid.major = ggplot2::element_line(linetype = 2),
          legend.title = ggplot2::element_text(face = "bold"))

  plot

}
