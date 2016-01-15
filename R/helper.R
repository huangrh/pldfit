# Subtract baseline of the the same pin in each cycle
pinBaseline <- function(datF = dat[-1], index = index, offset = 5) {
    for (level in (levels(index))) {
        row_idx = index == level
        for (col_idx in (names(dat))) {
            temp = dat[row_idx, ] # slice the data by the row index
            offset = offset # offset to the start and the end of the baseline
            start = min(temp$Time) + step_time['prebaseline'] + offset
            end = start + step_time['baseline'] - 2 * offset
            # further slice the data to just keep the baseline portion.
            temp =  dplyr::filter(dat[row_idx, ], Time > start, Time < end)
            baseline = mean(temp[[col_idx]]);
            dat[row_idx, col_idx] <- dat[row_idx, col_idx] - baseline
        }
    }
    return(dat)

}

