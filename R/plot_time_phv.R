#' Time to PHV Dumbell Plot
#'
#' This function returns a dumbell plot showing the difference (in years) between current age and estimated age at PHV for each athlete in the dataset.
#'
#' Athletes are ordered by the difference between current and estimated age at PHV, as shown on the right of the plot, from highest to lowest.
#'
#' Check the references cited on this package for further details on how these metrics are calculated.
#'
#'
#' @param data A data frame. The object containing the raw data we wish to analize.
#' @return A dumbell plot `(ggplot)`
#'
#' @export
#' @examples
#' plot_time_phv(data_sample)
#'

plot_time_phv <- function(data) {

  datos <- maturation_cm(data) %>%
    dplyr::select(Athlete, `Current Age` = Age, `Age @ PHV`)

  base_diff <- datos %>%
    dplyr::mutate(Diferenca = `Age @ PHV` - `Current Age`) %>%
    dplyr::arrange(Diferenca, desc(Athlete)) %>%
    dplyr::mutate(Athlete.fact = factor(Athlete, levels = unique(Athlete)))

  df_diff_gather_age <- base_diff %>%
    tidyr::gather(Metric, Value, -Athlete, -Athlete.fact, -Diferenca) %>%
    dplyr::select(Athlete, Athlete.fact, Metric, Value, Diferenca)

  plot <-  ggplot2::ggplot(data = df_diff_gather_age, ggplot2::aes( y = Athlete.fact, x = Value, color = Metric)) +
    ggplot2::geom_rect(ggplot2::aes(xmin = 16.8, xmax = Inf , ymin = -Inf, ymax = Inf), fill = "gray", color = "transparent") +
    ggplot2::geom_line(ggplot2::aes(group = Athlete), color = "gray", size = 1) +
    ggplot2::geom_point(size = 3, pch = 19) +
    ggplot2::geom_text(fontface = "bold", size = 3, colour = "black", ggplot2::aes(x = 17, y = Athlete, label =
                                                                   ifelse(Metric == "Age @ PHV", "",
                                                                          ifelse(Diferenca == 0, paste0(as.character(Diferenca)),
                                                                                 ifelse(Diferenca > 0, paste0("+",as.character(round(Diferenca,1))), paste0(as.character(round(Diferenca,1)))))))) +
    ggplot2::geom_text(ggplot2::aes(x = 17, y = -0.2, label = "Diff"), color = "white", size = 3) +
    ggplot2::geom_text(ggplot2::aes(x = 17, y = -1, label = ""), color = "transparent") +
    ggplot2::scale_color_manual(name="Time", values = c("Current Age" = "deepskyblue4", "Age @ PHV" = "deepskyblue3")) +
    ggplot2::ylab("Athlete \n") + ggplot2::xlab("\n Years") +
    ggplot2::labs(title = "Time to PHV", subtitle = "Length of time (in years) between Current Age and Age at PHV \n") +
    ggplot2::theme_light() +
    ggplot2::theme(axis.title.x = ggplot2::element_text(color = "grey", hjust = 0.9),
          axis.title.y = ggplot2::element_text(color = "grey", hjust = 1),
          plot.subtitle = ggplot2::element_text(color = "darkgray"),
          panel.grid.minor = ggplot2::element_blank(),
          panel.grid.major = ggplot2::element_line(linetype = 2),
          legend.title = ggplot2::element_text(face = "bold"))

  plot

}

