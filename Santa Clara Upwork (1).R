library(readxl)
library(writexl)
library(stringr)
library(httr)
library(rvest)
library(xml2)


# Remember to set work directory to read/write desired excel file if not using this cloud service


# check if the excel file is uploaded
filename = NULL
for(f in list.files(path = "/cloud/project")){
  if(str_detect(f, "xls")){
    filename <<- f
  }
}

if(is.null(filename) == TRUE){
  stop("No xls file detcted")
}

# read and store excel spreadsheet
SC = read_excel(filename)

# Function: to check if column exist
PA_exist <- function(ds,col_name){
  for(c in names(SC)){
    if(c == col_name){
      return(TRUE)
    }
  }
}

# check if column 'Property_Address' exist
if(is.null(PA_exist(SC,"Property_Address")) == TRUE){
  stop("No 'Property_Address' column detected")
}

# check if column 'Property_Type' exist
if(is.null(PA_exist(SC,"Property_Type")) == TRUE){
  stop("No 'Property_Type' column detected")
}


# Create the dataframe with removed rows where there is an emtpy value in Property_Address" column
SC  <-  subset(SC, !is.na(Property_Address))
dfF  <- subset(SC, !is.na(Property_Type)) # df with already "Property_Type" values filled
dfNA  <- subset(SC, is.na(Property_Type)) # df with "Property_Type" values yet to be filled

# Function: to check if text "Single Family" exist
S_Sing <- function(Ads){
  for(i in Ads){
    if(str_detect(i, "Single Family")){
      return(TRUE)
      break
    }
  }
}

# Function to access URL; submit form; perform search; and store results to "Property_Type" column
search <- function(Texts){
  x = 0
  for(j in Texts){
    x = x + 1
    # extract html document of the website
    html_doc = html_session("https://www.propertyshark.com/mason/")
    
    # find and fill the forms no. 1
    # nextpage is result of submitted form
    nextpage = submit_form(html_doc, set_values(html_form(html_doc)[[1]], search_token=j ,location='Santa Clara County, CA'))
    
    # if next page's title is "Lookup | PropertyShark"
    if(nextpage %>% html_nodes(xpath = '//title') %>% html_text() == "Lookup | PropertyShark"){
      dfNA$Property_Type[x]  <<- "_invalid input"
    
    # if next page's title is "UI | PropertyShark" meaning multiple listings
    }else if(nextpage %>% html_nodes(xpath = '//title') %>% html_text() == "UI | PropertyShark"){
      # if text "Single Family" is found
      if(is.null(S_Sing(nextpage %>% html_nodes(xpath = '//div[@class="description"]'))) == TRUE){
        dfNA$Property_Type[x]  <<- "_no single family"
      }else {
        dfNA$Property_Type[x]  <<- "Single Family"
      }
    
    # if next page is desired result page
    }else if(str_detect(nextpage %>% html_nodes(xpath = '//title') %>% html_text(),"Property Information | PropertyShark")){
      # if "Single Family" detected append "Single Family" meaning S_Sing() is not empty
      if(is.null(S_Sing(nextpage %>% html_nodes(xpath = '//div[@class="cols22"]') %>% html_text())) == FALSE){
        dfNA$Property_Type[x]  <<- "Single Family"
      # else store the "Property Type"
      }else {
        dfNA$Property_Type[x]  <<- str_trim(str_split(str_split((nextpage %>% html_nodes(xpath = '//div[@class="cols22"]') %>% html_text())[1], "\\(", simplify = T)[,1], " class\n", simplify = T)[,2])
      }
    
    }else {
      dfNA$Property_Type[x]  <<- "_error"
    }
  }
}

# Perform search
search(dfNA$Property_Address)

# combine a new data frame
SCNew  <- rbind(dfF,dfNA)

# write new excel file
write_xlsx(SCNew, "dataoutput.xlsx") 