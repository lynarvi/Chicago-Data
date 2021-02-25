# Chicago Dataset: Basic Data Frame Manipulation Using "dplyr" Package 

## Description
Daily air pollution and temperature data for Chicago

## Packages Installed
**dplyr** is a grammar of data manipulation providing a consistent set of verbs that help you solve the most common data manipulation challenges. These are combined naturally with `group_by()` which allows you to perform any operation "by group".

    install.packages("dplyr")

After installing the **dplyr** package, you must call its library.

    library("dplyr")
    
## Accessing the Chicago File
We can access the file through this link. Note that the data file is a `zip` file.

http://www.biostat.jhsph.edu/~rpeng/leanpub/rprog/chicago_data.zip

### Downloading and Unzipping the file directly from the web to R console
To download the file directly in R console use the codes below.

    download.file("http://www.biostat.jhsph.edu/~rpeng/leanpub/rprog/chicago_data.zip",destfile="chicago.zip")

After downloading the zip file we must unzip it. In unzipping a file you must open a connection to the zip archive and the file inside it using the function `unz()`

    con = unz("chicago.zip", filename = "chicago.rds")
 
 Apply `gzip` decompression to the connection using `gzcon()` function. This function provides a modified connection that wraps an existing connection and decompresses reads or compressess writes through that connection.
 
    con2 = gzcon(con)
 
To read the connection we must use the `readRDS()` function. We will store the data inside the variable **chicago**

    chicago = readRDS(con2)
    
Then we must close the connection.

    close(con2)
    
## Manipulating the Chicago Dataset  
    
### dim() and str()
To view the basic characteristics of the dataset we can use `dim()` and `str()` functions.

    dim(chicago)
    
    [1] 6940    8
    

    
    str(chicago)
    
    'data.frame':   6940 obs. of  8 variables:
    $ city      : chr  "chic" "chic" "chic" "chic" ...
    $ tmpd      : num  31.5 33 33 29 32 40 34.5 29 26.5 32.5 ...
    $ dptp      : num  31.5 29.9 27.4 28.6 28.9 ...
     $ date      : Date, format: "1987-01-01" "1987-01-02" ...
     $ pm25tmean2: num  NA NA NA NA NA NA NA NA NA NA ...
    $ pm10tmean2: num  34 NA 34.2 47 NA ...
     $ o3tmean2  : num  4.25 3.3 3.33 4.38 4.75 ...
     $ no2tmean2 : num  20 23.2 23.8 30.4 30.3 ...
    
    

Suppose we wanted to take the first 3 columns only. There are a few ways to do this. We could for example use numerical indices. But we can also use the names directly.

    name(chicago)[1:3]
    
    [1] "city" "tmpd" "dptp"
    
    
    subset = select(chicago, city:dptp)
    head(subset)
    
      city tmpd   dptp
    1 chic 31.5 31.500
    2 chic 33.0 29.875
    3 chic 33.0 27.375
    4 chic 29.0 28.625
    5 chic 32.0 28.875
    6 chic 40.0 35.125
   
Note: We used `head()` function to select only the first 6 rows in the dataframe. It also applies with the `tail()` function.


### select()

You can also omit variables using the `select()` function by using the negative sign. In this case we want to omit the variables **city** upto **dptp**.

    subset_omit = select(chicago, -(city:dptp))
    head(subset_omit)
    
                date pm25tmean2 pm10tmean2 o3tmean2 no2tmean2
        1 1987-01-01         NA   34.00000 4.250000  19.98810
        2 1987-01-02         NA         NA 3.304348  23.19099
        3 1987-01-03         NA   34.16667 3.333333  23.81548
        4 1987-01-04         NA   47.00000 4.375000  30.43452
        5 1987-01-05         NA         NA 4.750000  30.33333
        6 1987-01-06         NA   48.00000 5.833333  25.77233

The `select()` function also allows special syntax that allows you to specify variable names based on patterns. 

For example we want to:

- Keep every variable that **ends with a "2"**. We could do;

        subset = select(chicago, ends_with("2"))
        head(subset)
        
        'data.frame':   6940 obs. of  4 variables:
         $ pm25tmean2: num  NA NA NA NA NA NA NA NA NA NA ...
         $ pm10tmean2: num  34 NA 34.2 47 NA ...
         $ o3tmean2  : num  4.25 3.3 3.33 4.38 4.75 ...
        $ no2tmean2 : num  20 23.2 23.8 30.4 30.3 ...

- Keep every variable that **ends with a "d"**. We could do;
     
        subset = select(chicago, starts_with("d"))
        str(subset)
        
        'data.frame':   6940 obs. of  2 variables:
        $ dptp: num  31.5 29.9 27.4 28.6 28.9 ...
        $ date: Date, format: "1987-01-01" "1987-01-02" ...

## filter()
The `filter()` function is used to extract subsets of rows from the data frame. This
function is similar to the existing `subset()` function R but is quite a bit faster in past experiences.

- Suppose we want to extract the rows of Chicago data where the levels of **pm25tmean2 are greater than 30**.

         levels = filter(chicago, pm25tmean2 > 30)
         str(levels)
         
         'data.frame':   194 obs. of  8 variables:
         $ city      : chr  "chic" "chic" "chic" "chic" ...
         $ tmpd      : num  23 28 55 59 57 57 75 61 73 78 ...
         $ dptp      : num  21.9 25.8 51.3 53.7 52 56 65.8 59 60.3 67.1 ...
         $ date      : Date, format: "1998-01-17" "1998-01-23" ...
         $ pm25tmean2: num  38.1 34 39.4 35.4 33.3 ...
         $ pm10tmean2: num  32.5 38.7 34 28.5 35 ...
         $ o3tmean2  : num  3.18 1.75 10.79 14.3 20.66 ...
         $ no2tmean2 : num  25.3 29.4 25.3 31.4 26.8 ...

- We can place an arbitrary complex logical sequence inside of ``filter ()``, so we could for example extract the rows where **pm25tmean2 is greater than 30 and temperature is greater than 80 degrees Fahrenheit**.

        data.filter = filter(chicago, pm25tmean2 > 30 & tmpd > 80)
        str(data.filter)
        
        data.frame':   17 obs. of  8 variables:
        $ city      : chr  "chic" "chic" "chic" "chic" ...
        $ tmpd      : num  81 81 82 84 85 84 82 82 81 82 ...
        $ dptp      : num  71.2 70.4 72.2 72.9 72.6 72.6 67.4 63.5 70.4 66.2 ...
        $ date      : Date, format: "1998-08-23" "1998-09-06" ...
        $ pm25tmean2: num  39.6 31.5 32.3 43.7 38.8 ...
        $ pm10tmean2: num  59 50.5 58.5 81.5 70 66 80.5 65 64 72.5 ...
        $ o3tmean2  : num  45.9 50.7 33 45.2 38 ...
        $ no2tmean2 : num  14.3 20.3 33.7 27.4 27.6 ...



## summary()
`summary()` function is a generic function used to produce result summaries of the results of various model fitting functions. The function invokes particular methods which depend on the class of the first argument. 

In this case, we want to find the summary of the **pm25tmean2** in chicago data.

    summary(chicago$pm25tmean2)
    
    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
    1.70    9.70   14.66   16.23   20.60   61.50    4447 
   

## arrange()
The `arrange()` function is used to reorder rows of a data frame according to one
of the variables/columns. Reordering rows of a data frame (while preserving
corresponding order of other columns) is normally a pain to do in R. The `arrange()`
function simplifies the process quite a bit.

Columns can be arranged in descending order too by using the special `desc()` operator.

    data.arrange = arrange(chicago, desc(date))
    head(data.arrange)
    
        city tmpd dptp       date pm25tmean2 pm10tmean2  o3tmean2 no2tmean2
    1 chic   35 30.1 2005-12-31   15.00000       23.5  2.531250  13.25000
    2 chic   36 31.0 2005-12-30   15.05714       19.2  3.034420  22.80556
    3 chic   35 29.4 2005-12-29    7.45000       23.5  6.794837  19.97222
    4 chic   37 34.5 2005-12-28   17.75000       27.5  3.260417  19.28563
    5 chic   40 33.6 2005-12-27   23.56000       27.0  4.468750  23.50000
    6 chic   35 29.6 2005-12-26    8.40000        8.5 14.041667  16.81944

    tail(data.arrange)
    
         city tmpd   dptp       date pm25tmean2 pm10tmean2 o3tmean2 no2tmean2
    6935 chic 40.0 35.125 1987-01-06         NA   48.00000 5.833333  25.77233
    6936 chic 32.0 28.875 1987-01-05         NA         NA 4.750000  30.33333
    6937 chic 29.0 28.625 1987-01-04         NA   47.00000 4.375000  30.43452
    6938 chic 33.0 27.375 1987-01-03         NA   34.16667 3.333333  23.81548
    6939 chic 33.0 29.875 1987-01-02         NA         NA 3.304348  23.19099
    6940 chic 31.5 31.500 1987-01-01         NA   34.00000 4.250000  19.98810
    
 
 ### rename()
 The `rename()` function is designed to make renaming variables easier.
 
 Suppose we want to change the **dptp** column to represent the **dew point temperature** and the **pm25tmean2** column provides the **PM25** data.
 
    ChicagoNew = rename(chicago, "dew point temperature" = dptp, "PM25" = pm25tmean2)
    head(ChicagoNew)
    
      city tmpd dew point temperature       date PM25 pm10tmean2 o3tmean2 no2tmean2
    1 chic 31.5                31.500 1987-01-01   NA   34.00000 4.250000  19.98810
    2 chic 33.0                29.875 1987-01-02   NA         NA 3.304348  23.19099
    3 chic 33.0                27.375 1987-01-03   NA   34.16667 3.333333  23.81548
    4 chic 29.0                28.625 1987-01-04   NA   47.00000 4.375000  30.43452
    5 chic 32.0                28.875 1987-01-05   NA         NA 4.750000  30.33333
    6 chic 40.0                35.125 1987-01-06   NA   48.00000 5.833333  25.77233
 
 The syntax inside the `rename()` function is to have the new name on the left-hand
side of the = sign and the old name on the right-hand side.

 
 ### mutate()
The `mutate()` function use to compute transformations of variables in a data
frame. Every so often, if you want to create new variables that are derived from
existing variables and `mutate()` provides a clear interface for doing that.

For example, with `PM25`, we want to create a `pm25detrend` variable that subtracts the mean from the `PM25` variable.

    ChicagoMutated = mutate(ChicagoNew, pm25detrend = PM25 - mean(PM25, na.rm = TRUE))
    head(ChicagoMutated)
    
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

    tail(ChicagoMutated)
    
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

### transmute()
There is also the related `transmute()` function, which does the same thingas `mutate()` but then drops all non-transformed variables.

Here we detrend pm10 and ozone (03) variables.

    head(transmute(chicago, pm10detrend = pm10tmean2 - mean(pm10tmean2, na.rm =TRUE), o3detrend = o3tmean2 - mean(o3tmean2, na.rm = TRUE)))

      pm10detrend o3detrend
    1   0.1047939 -15.18551
    2          NA -16.13117
    3   0.2714605 -16.10218
    4  13.1047939 -15.06051
    5          NA -14.68551
    6  14.1047939 -13.60218

### groupby()
The `group_by()` function is used to generate summary statistics from the data
frame within strata defined by a variable. For example, in this chicago data, you might want to get the average annual level of pm25tmean2, o3tmean2 and no2tmean where stratum is the year (from 1987 to 2005).

**Note:** We can create a **year** variable using `as.POSIXlt()` function.

    chicago_new = mutate(chicago, year = as.POSIXlt(date)$year + 1900)
    head(chicago_new) 
    
      city tmpd   dptp       date pm25tmean2 pm10tmean2 o3tmean2 no2tmean2 year
    1 chic 31.5 31.500 1987-01-01         NA   34.00000 4.250000  19.98810 1987
    2 chic 33.0 29.875 1987-01-02         NA         NA 3.304348  23.19099 1987
    3 chic 33.0 27.375 1987-01-03         NA   34.16667 3.333333  23.81548 1987
    4 chic 29.0 28.625 1987-01-04         NA   47.00000 4.375000  30.43452 1987
    5 chic 32.0 28.875 1987-01-05         NA         NA 4.750000  30.33333 1987
    6 chic 40.0 35.125 1987-01-06         NA   48.00000 5.833333  25.77233 1987
    
    years = group_by(chicago_new,year)
    head(years)
    
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
    
    summarize(years, PM25 = mean(pm25tmean2, na.rm = TRUE), o3 = max(o3tmean2, na.rm = TRUE), no2 = median(no2tmean2, na.rm = TRUE))
    
    # A tibble: 19 x 4
        year  PM25    o3   no2
     * <dbl> <dbl> <dbl> <dbl>
     1  1987 NaN    63.0  23.5
     2  1988 NaN    61.7  24.5
     3  1989 NaN    59.7  26.1
     4  1990 NaN    52.2  22.6
     5  1991 NaN    63.1  21.4
     6  1992 NaN    50.8  24.8
     7  1993 NaN    44.3  25.8
     8  1994 NaN    52.2  28.5
     9  1995 NaN    66.6  27.3
    10  1996 NaN    58.4  26.4
    11  1997 NaN    56.5  25.5
    12  1998  18.3  50.7  24.6
    13  1999  18.5  57.5  24.7
    14  2000  16.9  55.8  23.5
    15  2001  16.9  51.8  25.1
    16  2002  15.3  54.9  22.7
    17  2003  15.2  56.2  24.6
    18  2004  14.6  44.5  23.4
    19  2005  16.2  58.8  22.6
    
    
    
    
    
    
