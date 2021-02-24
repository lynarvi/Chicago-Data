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

(http://www.biostat.jhsph.edu/~rpeng/leanpub/rprog/chicago_data.zip)

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

Try to check if the data is stored in the variable `chicago`

    head(chicago)
    
 <div align="left">
    <img width="1024" height="690"
         src="">
<div/>
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
