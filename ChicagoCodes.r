> library("dplyr")

Attaching package: ‘dplyr’

The following objects are masked from ‘package:stats’:

    filter, lag

The following objects are masked from ‘package:base’:

    intersect, setdiff, setequal, union

> download.file("http://www.biostat.jhsph.edu/~rpeng/leanpub/rprog/chicago_data.zip",destfile="chicago.zip")
trying URL 'http://www.biostat.jhsph.edu/~rpeng/leanpub/rprog/chicago_data.zip'
Content type 'application/zip' length 115014 bytes (112 KB)
downloaded 112 KB

> con = unz("chicago.zip", filename = "chicago.rds")
> con2 = gzcon(con)
> chicago = readRDS(con2)
>  close(con2)
> dim(chicago)
[1] 6940    8
>  str(chicago)
'data.frame':   6940 obs. of  8 variables:
 $ city      : chr  "chic" "chic" "chic" "chic" ...
 $ tmpd      : num  31.5 33 33 29 32 40 34.5 29 26.5 32.5 ...
 $ dptp      : num  31.5 29.9 27.4 28.6 28.9 ...
 $ date      : Date, format: "1987-01-01" "1987-01-02" ...
 $ pm25tmean2: num  NA NA NA NA NA NA NA NA NA NA ...
 $ pm10tmean2: num  34 NA 34.2 47 NA ...
 $ o3tmean2  : num  4.25 3.3 3.33 4.38 4.75 ...
 $ no2tmean2 : num  20 23.2 23.8 30.4 30.3 ...
>   names(chicago)[1:3]
[1] "city" "tmpd" "dptp"
>  subset = select(chicago, city:dptp)
>     head(subset)
  city tmpd   dptp
1 chic 31.5 31.500
2 chic 33.0 29.875
3 chic 33.0 27.375
4 chic 29.0 28.625
5 chic 32.0 28.875
6 chic 40.0 35.125
>  subset_omit = select(chicago, -(city:dptp))
>     head(subset_omit)
        date pm25tmean2 pm10tmean2 o3tmean2 no2tmean2
1 1987-01-01         NA   34.00000 4.250000  19.98810
2 1987-01-02         NA         NA 3.304348  23.19099
3 1987-01-03         NA   34.16667 3.333333  23.81548
4 1987-01-04         NA   47.00000 4.375000  30.43452
5 1987-01-05         NA         NA 4.750000  30.33333
6 1987-01-06         NA   48.00000 5.833333  25.77233
>  subset = select(chicago, ends_with("2"))
>         head(subset)
  pm25tmean2 pm10tmean2 o3tmean2 no2tmean2
1         NA   34.00000 4.250000  19.98810
2         NA         NA 3.304348  23.19099
3         NA   34.16667 3.333333  23.81548
4         NA   47.00000 4.375000  30.43452
5         NA         NA 4.750000  30.33333
6         NA   48.00000 5.833333  25.77233
>  subset = select(chicago, starts_with("d"))
>         str(subset)
'data.frame':   6940 obs. of  2 variables:
 $ dptp: num  31.5 29.9 27.4 28.6 28.9 ...
 $ date: Date, format: "1987-01-01" "1987-01-02" ...
> levels = filter(chicago, pm25tmean2 > 30)
>          str(levels)
'data.frame':   194 obs. of  8 variables:
 $ city      : chr  "chic" "chic" "chic" "chic" ...
 $ tmpd      : num  23 28 55 59 57 57 75 61 73 78 ...
 $ dptp      : num  21.9 25.8 51.3 53.7 52 56 65.8 59 60.3 67.1 ...
 $ date      : Date, format: "1998-01-17" "1998-01-23" ...
 $ pm25tmean2: num  38.1 34 39.4 35.4 33.3 ...
 $ pm10tmean2: num  32.5 38.7 34 28.5 35 ...
 $ o3tmean2  : num  3.18 1.75 10.79 14.3 20.66 ...
 $ no2tmean2 : num  25.3 29.4 25.3 31.4 26.8 ...
> data.filter = filter(chicago, pm25tmean2 > 30 & tmpd > 80)
>         str(data.filter)
'data.frame':   17 obs. of  8 variables:
 $ city      : chr  "chic" "chic" "chic" "chic" ...
 $ tmpd      : num  81 81 82 84 85 84 82 82 81 82 ...
 $ dptp      : num  71.2 70.4 72.2 72.9 72.6 72.6 67.4 63.5 70.4 66.2 ...
 $ date      : Date, format: "1998-08-23" "1998-09-06" ...
 $ pm25tmean2: num  39.6 31.5 32.3 43.7 38.8 ...
 $ pm10tmean2: num  59 50.5 58.5 81.5 70 66 80.5 65 64 72.5 ...
 $ o3tmean2  : num  45.9 50.7 33 45.2 38 ...
 $ no2tmean2 : num  14.3 20.3 33.7 27.4 27.6 ...
> summary(chicago$pm25tmean2)
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
   1.70    9.70   14.66   16.23   20.60   61.50    4447 
> data.arrange = arrange(chicago, desc(date))
> head(data.arrange)
  city tmpd dptp       date pm25tmean2 pm10tmean2  o3tmean2 no2tmean2
1 chic   35 30.1 2005-12-31   15.00000       23.5  2.531250  13.25000
2 chic   36 31.0 2005-12-30   15.05714       19.2  3.034420  22.80556
3 chic   35 29.4 2005-12-29    7.45000       23.5  6.794837  19.97222
4 chic   37 34.5 2005-12-28   17.75000       27.5  3.260417  19.28563
5 chic   40 33.6 2005-12-27   23.56000       27.0  4.468750  23.50000
6 chic   35 29.6 2005-12-26    8.40000        8.5 14.041667  16.81944
> ChicagoNew = rename(chicago, "dew point temperature" = dptp, "PM25" = pm25tmean2)
> head(ChicagoNew)
  city tmpd dew point temperature       date PM25 pm10tmean2 o3tmean2 no2tmean2
1 chic 31.5                31.500 1987-01-01   NA   34.00000 4.250000  19.98810
2 chic 33.0                29.875 1987-01-02   NA         NA 3.304348  23.19099
3 chic 33.0                27.375 1987-01-03   NA   34.16667 3.333333  23.81548
4 chic 29.0                28.625 1987-01-04   NA   47.00000 4.375000  30.43452
5 chic 32.0                28.875 1987-01-05   NA         NA 4.750000  30.33333
6 chic 40.0                35.125 1987-01-06   NA   48.00000 5.833333  25.77233
> ChicagoMutated = mutate(ChicagoNew, pm25detrend = PM25 - mean(PM25, na.rm = TRUE))
> head(ChicagoMutated)
  city tmpd dew point temperature       date PM25 pm10tmean2 o3tmean2 no2tmean2
1 chic 31.5                31.500 1987-01-01   NA   34.00000 4.250000  19.98810
2 chic 33.0                29.875 1987-01-02   NA         NA 3.304348  23.19099
3 chic 33.0                27.375 1987-01-03   NA   34.16667 3.333333  23.81548
4 chic 29.0                28.625 1987-01-04   NA   47.00000 4.375000  30.43452
5 chic 32.0                28.875 1987-01-05   NA         NA 4.750000  30.33333
6 chic 40.0                35.125 1987-01-06   NA   48.00000 5.833333  25.77233
  pm25detrend
1          NA
2          NA
3          NA
4          NA
5          NA
6          NA
> tail(ChicagoMutated)
     city tmpd dew point temperature       date     PM25 pm10tmean2  o3tmean2
6935 chic   35                  29.6 2005-12-26  8.40000        8.5 14.041667
6936 chic   40                  33.6 2005-12-27 23.56000       27.0  4.468750
6937 chic   37                  34.5 2005-12-28 17.75000       27.5  3.260417
6938 chic   35                  29.4 2005-12-29  7.45000       23.5  6.794837
6939 chic   36                  31.0 2005-12-30 15.05714       19.2  3.034420
6940 chic   35                  30.1 2005-12-31 15.00000       23.5  2.531250
     no2tmean2 pm25detrend
6935  16.81944   -7.830958
6936  23.50000    7.329042
6937  19.28563    1.519042
6938  19.97222   -8.780958
6939  22.80556   -1.173815
6940  13.25000   -1.230958
> head(transmute(chicago, pm10detrend = pm10tmean2 - mean(pm10tmean2, na.rm =TRUE), o3detrend = o3tmean2 - mean(o3tmean2, na.rm = TRUE)))
  pm10detrend o3detrend
1   0.1047939 -15.18551
2          NA -16.13117
3   0.2714605 -16.10218
4  13.1047939 -15.06051
5          NA -14.68551
6  14.1047939 -13.60218
> chicago_new = mutate(chicago, year = as.POSIXlt(date)$year + 1900)
> head(chicago_new) 
  city tmpd   dptp       date pm25tmean2 pm10tmean2 o3tmean2 no2tmean2 year
1 chic 31.5 31.500 1987-01-01         NA   34.00000 4.250000  19.98810 1987
2 chic 33.0 29.875 1987-01-02         NA         NA 3.304348  23.19099 1987
3 chic 33.0 27.375 1987-01-03         NA   34.16667 3.333333  23.81548 1987
4 chic 29.0 28.625 1987-01-04         NA   47.00000 4.375000  30.43452 1987
5 chic 32.0 28.875 1987-01-05         NA         NA 4.750000  30.33333 1987
6 chic 40.0 35.125 1987-01-06         NA   48.00000 5.833333  25.77233 1987
> years = group_by(chicago_new,year)
> head(years)
# A tibble: 6 x 9
# Groups:   year [1]
  city   tmpd  dptp date       pm25tmean2 pm10tmean2 o3tmean2 no2tmean2  year
  <chr> <dbl> <dbl> <date>          <dbl>      <dbl>    <dbl>     <dbl> <dbl>
1 chic   31.5  31.5 1987-01-01         NA       34       4.25      20.0  1987
2 chic   33    29.9 1987-01-02         NA       NA       3.30      23.2  1987
3 chic   33    27.4 1987-01-03         NA       34.2     3.33      23.8  1987
4 chic   29    28.6 1987-01-04         NA       47       4.38      30.4  1987
5 chic   32    28.9 1987-01-05         NA       NA       4.75      30.3  1987
6 chic   40    35.1 1987-01-06         NA       48       5.83      25.8  1987
> summarize(years, PM25 = mean(pm25tmean2, na.rm = TRUE), o3 = mean(o3tmean2, na.rm = TRUE), no2 = mean(no2tmean2, na.rm = TRUE))
# A tibble: 19 x 4
    year  PM25    o3   no2
 * <dbl> <dbl> <dbl> <dbl>
 1  1987 NaN    20.5  25.3
 2  1988 NaN    22.2  25.3
 3  1989 NaN    20.8  27.4
 4  1990 NaN    19.7  23.1
 5  1991 NaN    20.0  21.9
 6  1992 NaN    16.1  25.9
 7  1993 NaN    15.8  26.1
 8  1994 NaN    17.3  29.1
 9  1995 NaN    18.1  27.9
10  1996 NaN    16.7  27.0
11  1997 NaN    18.6  25.8
12  1998  18.3  19.3  24.7
13  1999  18.5  20.5  24.9
14  2000  16.9  18.5  24.1
15  2001  16.9  19.4  25.4
16  2002  15.3  21.0  23.7
17  2003  15.2  21.0  25.2
18  2004  14.6  20.5  23.4
19  2005  16.2  23.2  23.2
> qq <- quantile(ChicagoNew$PM25, seq(0, 1, 0.2), na.rm = TRUE)
> chicago.new = mutate(ChicagoNew, PM25.quint = cut(PM25,qq))
> head(chicago.new)
  city tmpd dew point temperature       date PM25 pm10tmean2 o3tmean2 no2tmean2
1 chic 31.5                31.500 1987-01-01   NA   34.00000 4.250000  19.98810
2 chic 33.0                29.875 1987-01-02   NA         NA 3.304348  23.19099
3 chic 33.0                27.375 1987-01-03   NA   34.16667 3.333333  23.81548
4 chic 29.0                28.625 1987-01-04   NA   47.00000 4.375000  30.43452
5 chic 32.0                28.875 1987-01-05   NA         NA 4.750000  30.33333
6 chic 40.0                35.125 1987-01-06   NA   48.00000 5.833333  25.77233
  PM25.quint
1       <NA>
2       <NA>
3       <NA>
4       <NA>
5       <NA>
6       <NA>
> GroupByPM25 = group_by(chicago.new,PM25.quint)
> GroupByPM25
# A tibble: 6,940 x 9
# Groups:   PM25.quint [6]
   city   tmpd `dew point temp~ date        PM25 pm10tmean2 o3tmean2 no2tmean2
   <chr> <dbl>            <dbl> <date>     <dbl>      <dbl>    <dbl>     <dbl>
 1 chic   31.5             31.5 1987-01-01    NA       34       4.25      20.0
 2 chic   33               29.9 1987-01-02    NA       NA       3.30      23.2
 3 chic   33               27.4 1987-01-03    NA       34.2     3.33      23.8
 4 chic   29               28.6 1987-01-04    NA       47       4.38      30.4
 5 chic   32               28.9 1987-01-05    NA       NA       4.75      30.3
 6 chic   40               35.1 1987-01-06    NA       48       5.83      25.8
 7 chic   34.5             26.8 1987-01-07    NA       41       9.29      20.6
 8 chic   29               22   1987-01-08    NA       36      11.3       17.0
 9 chic   26.5             29   1987-01-09    NA       33.3     4.5       23.4
10 chic   32.5             27.8 1987-01-10    NA       NA       4.96      19.5
# ... with 6,930 more rows, and 1 more variable: PM25.quint <fct>
> 
> summarize(GroupByPM25, mean(o3tmean2, na.rm = TRUE),mean(no2tmean2, na.rm = TRUE))
# A tibble: 6 x 3
  PM25.quint  `mean(o3tmean2, na.rm = TRUE)` `mean(no2tmean2, na.rm = TRUE)`
* <fct>                                <dbl>                           <dbl>
1 (1.7,8.7]                             21.7                            18.0
2 (8.7,12.4]                            20.4                            22.1
3 (12.4,16.7]                           20.7                            24.4
4 (16.7,22.6]                           19.9                            27.3
5 (22.6,61.5]                           20.3                            29.6
6 <NA>                                  18.8                            25.8
> 
