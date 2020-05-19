library(rvest)
library(data.table)
vignette("selectorgadget")
teampage <- read_html("https://www.bls.gov/lau/lastrk17.htm")
team_names = teampage %>% html_nodes(".sub0") %>% html_text()

teampage2 <- read_html("https://www.bls.gov/lau/lastrk17.htm")
num = teampage2 %>% html_nodes("#lastrk17 td:nth-child(2)") %>% html_text()
Unempoyment_rate = as.numeric(num)

unemp = data.frame(STATES = team_names[2:52], Unempoyment_rate = Unempoyment_rate[2:52])
unemp

write.csv(unemp, "2017_unemployment Rate.csv", row.names = F)


t1 = read.csv("Population Estimates by State.csv")
t2 = read.csv("2017_unemployment Rate.csv")
head(t1)
head(t2)
dim(t1)
dim(t2)

t1$Unempoyment_rate = rep(NA, 52)
for (i in 1:52) {
  for (j in 1:51) {
    if(t1$State[i] == t2$STATES[j]) {
      t1$Unempoyment_rate[i] = t2$Unempoyment_rate[j]
    }
  }
}

t1[30,4] = 10.3
t1$State = as.character(t1$State)

for (i in 1:52) {
  for (j in 1:50) {
    if(t1$State[i] == state.name[j]) {
      t1$State[i] = state.abb[j]
    }
  }
}

t1[50,1] = "DC"
t1[30,1] = "PR"
t1
write.csv(t1, "2017_extra_data.csv", row.names = F)


