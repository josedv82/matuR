#' % Adult Height & Puberty States Plot
#'
#' This function returns a ggplot object showing the % of adult height for each subject in the dataset. It adds a background color to highlight maturity categories.
#'
#' @param data A data frame. The object containing the raw data we wish to analize.
#' @return A plot `(ggplot)`
#'
#' @export
#' @examples
#' plot_puberty_stages(data_sample)
#'

plot_puberty_stages <- function(data) {

  df<-data.frame(xmin=c(-Inf, 85, 90, 95),
                 xmax=c(85, 90, 95, Inf),
                 ymin=c(-Inf,-Inf, -Inf, -Inf),
                 ymax=c(Inf,Inf, Inf, Inf),
                 Stages=c("4. Pre","3. Early", "2. Mid", "1. Late"))

  plot <- maturation_cm(data) %>%
    ggplot2::ggplot(ggplot2::aes(x = `% Adult Height`, y = reorder(Athlete, `% Adult Height`), label = `% Adult Height`)) +
    ggplot2::geom_rect(data=df, ggplot2::aes(xmin=xmin,ymin=ymin,xmax=xmax,ymax=ymax,fill=Stages), alpha = 0.5, inherit.aes=FALSE) +
    ggplot2::geom_point(size = 2) +
    ggplot2::scale_x_continuous(breaks = seq(0, 100, by = 2.5)) +
    ggplot2::scale_fill_manual(values=c("4. Pre" = "#eacab9", "1. Late" = "#83aeae", "2. Mid" = "#a8d8bd", "3. Early" = "#f9f0cb")) +
    ggplot2::ylab("Athletes \n") + ggplot2::xlab("\n % of Adult Height") +
    ggplot2::ggtitle("\n % Predicted Adult Height", subtitle =  "       Puberty Stages \n") +
    ggplot2::theme_light() +
    ggplot2::theme(axis.title.x = ggplot2::element_text(color = "grey", hjust = 1),
          axis.title.y = ggplot2::element_text(color = "grey", hjust = 1),
          plot.subtitle = ggplot2::element_text(color = "darkgray"),
          panel.grid.minor = ggplot2::element_blank(),
          panel.grid.major = ggplot2::element_line(linetype = 2),
          legend.title = ggplot2::element_blank())

  plot

}
