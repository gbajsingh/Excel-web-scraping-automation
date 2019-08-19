library(readxl)
library(writexl)
library(stringr)
library(httr)
library(rvest)
library(xml2)

#Uncomment the following line if running this script on local computer instead of this cloud notebook(to set working directory to read and write excel file to desktop folder) 
#setwd("C:/Users/bajsingh/Desktop")



# read and store excel spreadsheet
# SC = read_excel("Ex-Santa Cruz - Tax Delinquent.xls")
SC = read_excel(paste("../input/",list.files(path = "../input"), sep=""))

# change column name to the appropriate name 
colnames(SC)[colnames(SC)=="Situs Property Full Address"] <- "Situs_Property_Full_Address"
# colnames(SC)[colnames(SC)=="Property Class"] <- "Property_Class"

# take out rows with no input in "Situs_Property_Full_Address" column
SC = subset(SC, !is.na(Situs_Property_Full_Address))


# create new dataframe with "Situs_Propert_Adress" column only
df = subset(SC, select = c(Situs_Property_Full_Address))


# # Function: extract Search text from Addresses to submit the web page form; store it to S_Text vector
ext_S_text = function(Addresses){
  S_Text  =  c()
  x = 0
  for(i in Addresses){
    x = 1 + x
      
    # look by city names first
    if(str_detect(i, " SANTA CRUZ CA ")){
      S_Text[x] = str_split(i, " SANTA CRUZ CA ", simplify = T)[,1]
    }else if(str_detect(i, " WATSONVILLE CA ")){
      S_Text[x] = str_split(i, " WATSONVILLE CA ", simplify = T)[,1]
    }else if(str_detect(i, " FREEDOM CA ")){
      S_Text[x] = str_split(i, " FREEDOM CA ", simplify = T)[,1]
    }else if(str_detect(i, " SCOTTS VALLEY CA ")){
      S_Text[x] = str_split(i, " SCOTTS VALLEY CA ", simplify = T)[,1]
    }else if(str_detect(i, " SOQUEL CA ")){
      S_Text[x] = str_split(i, " SOQUEL CA ", simplify = T)[,1]
    }else if(str_detect(i, " CAPITOLA CA ")){
      S_Text[x] = str_split(i, " CAPITOLA CA ", simplify = T)[,1]
    }else if(str_detect(i, " APTOS CA ")){
      S_Text[x] = str_split(i, " APTOS CA ", simplify = T)[,1]
    }else if(str_detect(i, " DAVENPORT CA ")){
      S_Text[x] = str_split(i, " DAVENPORT CA ", simplify = T)[,1]
    }else if(str_detect(i, " LA SELVA BCH CA ")){
      S_Text[x] = str_split(i, " LA SELVA BCH CA ", simplify = T)[,1]
    }else if(str_detect(i, " PARADISE PARK CA ")){
      S_Text[x] = str_split(i, " PARADISE PARK CA ", simplify = T)[,1]
    }else if(str_detect(i, " BONNY DOON CA ")){
      S_Text[x] = str_split(i, " BONNY DOON CA ", simplify = T)[,1]
    }else if(str_detect(i, " FELTON CA ")){
      S_Text[x] = str_split(i, " FELTON CA ", simplify = T)[,1]
    }else if(str_detect(i, " MT HERMON CA ")){
      S_Text[x] = str_split(i, " MT HERMON CA ", simplify = T)[,1]
    }else if(str_detect(i, " BEN LOMOND CA ")){
      S_Text[x] = str_split(i, " BEN LOMOND CA ", simplify = T)[,1]
    }else if(str_detect(i, " BOULDER CREEK CA ")){
      S_Text[x] = str_split(i, " BOULDER CREEK CA ", simplify = T)[,1]
    }else if(str_detect(i, " BROOKDALE CA ")){
      S_Text[x] = str_split(i, " BROOKDALE CA ", simplify = T)[,1]
    }else if(str_detect(i, " LOS GATOS CA ")){
      S_Text[x] = str_split(i, " LOS GATOS CA ", simplify = T)[,1]

    # look by AVE, ST, RD, LN etc.
    }else if(str_detect(i, " ST ")){
      S_Text[x] = str_split(i, " ST ", simplify = T)[,1]
    }else if(str_detect(i, " LN ")){
      S_Text[x] = str_split(i, " LN ", simplify = T)[,1]
    }else if(str_detect(i, " RD ")){
      S_Text[x] = str_split(i, " RD ", simplify = T)[,1]
    }else if(str_detect(i, " AVE ")){
      S_Text[x] = str_split(i, " AVE ", simplify = T)[,1]
    }else if(str_detect(i, " DR ")){
      S_Text[x] = str_split(i, " DR ", simplify = T)[,1]
    }else if(str_detect(i, " BLVD ")){
      S_Text[x] = str_split(i, " BLVD ", simplify = T)[,1]
    }else if(str_detect(i, " CT ")){
      S_Text[x] = str_split(i, " CT ", simplify = T)[,1]
    }else if(str_detect(i, " CIR ")){
      S_Text[x] = str_split(i, " CIR ", simplify = T)[,1]
    }else if(str_detect(i, " PL ")){
      S_Text[x] = str_split(i, " PL ", simplify = T)[,1]
    }else if(str_detect(i, " WAY ")){
      S_Text[x] = str_split(i, " WAY ", simplify = T)[,1]
    }else if(str_detect(i, " TER ")){
      S_Text[x] = str_split(i, " TER ", simplify = T)[,1]
    }else if(str_detect(i, " LP ")){
      S_Text[x] = str_split(i, " LP ", simplify = T)[,1]
    }else if(str_detect(i, " LOOP ")){
      S_Text[x] = str_split(i, " LOOP ", simplify = T)[,1]
    }else if(str_detect(i, " PKWY ")){
      S_Text[x] = str_split(i, " PKWY ", simplify = T)[,1]
    }else if(str_detect(i, " AVENUE ")){
      S_Text[x] = str_split(i, " AVENUE ", simplify = T)[,1]

    # if no city name or AVE,DR,LN etc. detcted then
    }else {S_Text[x] = i}
  }
  return(S_Text)
}


# Function to access URL; submit form; perform search; and store results to PropertyClass vector
search_results = function(search_Texts){
  PropertyClass = c()
  for(j in search_Texts){
    html_doc = html_session("https://sccounty01.co.santa-cruz.ca.us/ASR/")        # html document of the website 
    form = html_form(html_doc)[[1]]                                               # find all forms in the doc & choose form # 1
    fillform = set_values(form, txtAPNNO='',txtSitus=j)                           # fill the form
    nextpage = submit_form(html_doc, fillform)                                    # submit form to get to next/resulting page
    
    if(nextpage %>% html_nodes(xpath = '//title') %>% html_text() == "Home Page"){  # If resulting page's title is still "Home Page"
                                                                                    # Then find the appropriate position in string to add '#'
      if(str_detect(str_sub(j, -2)," [A-Z0-9]")){                                   # And search again                                                                         
        j = paste(str_sub(j,1,-2), "#", str_sub(j, -1), sep="")
        PropertyClass = append(PropertyClass, search_results(j))
        next
      }else if(str_detect(str_sub(j, -3)," [A-Z0-9][A-Z0-9]")){
        j = paste(str_sub(j,1,-3), "#", str_sub(j, -2), sep="")
        PropertyClass = append(PropertyClass, search_results(j))
        next
      }else if(str_detect(str_sub(j, -4)," [A-Z0-9][A-Z0-9][A-Z0-9]")){
        j = paste(str_sub(j,1,-4), "#", str_sub(j, -3), sep="")
        PropertyClass = append(PropertyClass, search_results(j))
        next
      }else if(str_detect(str_sub(j, -5)," [A-Z0-9][A-Z0-9][A-Z0-9][A-Z0-9]")){
        j = paste(str_sub(j,1,-5), "#", str_sub(j, -4), sep="")
        PropertyClass = append(PropertyClass, search_results(j))
        next
      }else {
        PropertyClass = append(PropertyClass, "invalid input")
        next
      }
    }
    T_r <- nextpage %>% html_nodes(xpath = '//div[@class="plmTr"]') %>% html_text()    # text inside table rows of result table
    Class_r <- nextpage %>% html_nodes(xpath = '//div[@title="Class"]') %>% html_text()# text inside Class column
    z = 0
    for(r in T_r){
      z = z + 1
      # if "(inactice)" not detected inside the table row's text  
      if(!str_detect(r,"(Inactive)")){
        # then extract the appropriate text inside Class column; append it to PropertyClass vector 
        PropertyClass = append(PropertyClass, str_split(str_sub(Class_r[z], 71, -1), "\r\n ", simplify = T)[,1])
        break
      }
    }
  }
  return(PropertyClass)
}

# add property_Class Column
SC$Property_Class = search_results(ext_S_text(df$Situs_Property_Full_Address))

# write new excel file
#write.csv(SC,"mydataK.csv",row.names = FALSE)
write_xlsx(SC, "Santa Cruz - Tax .xlsx")
