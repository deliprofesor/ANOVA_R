library(tidyverse)
library(rstatix)
library(ggpubr)
heart <- read.csv("/home/yorgun/r_tube/Rcode/ANOVA-MANOVA/heart.csv")
View(heart)
# iki yönlü varyans analizi

df <- heart %>% filter(chol < 400)
df %>% group_by(cp, fbs ) %>% summarise(Shapiro = shapiro.test(chol)$p.value)
bartlett.test(df$chol ~ interaction(df$cp, df$fbs))

#bağımlı ~ bağımsız
anova_1 <- aov(df$chol ~ as.factor(df$cp) * as.factor(df$fbs))
summary(anova_1)

#rstatix
anova_test(df, dv= chol, between = c(cp, fbs))
# burada bir anlamlılık yok 

#istersen chol 400 kısmını çıkart 
anova_1 <- aov(df$trestbps ~ as.factor(df$cp) * as.factor(df$fbs))
summary(anova_1)
anova_test(df, dv= trestbps, between = c(cp, fbs))

ggboxplot(df, x = c("cp", "fbs"), y = "trestbps")

#TukeyHSB Testi 

identify_outliers(heart["trestbps"]) #df olarak almamız lazım 


df_new <- heart %>% filter(trestbps < 172)
View(df_new)

int_groups <- apply(df_new, MARGIN = 1, FUN = function(x){


                r <- paste0(x["cp"], ' - ', x["fbs"])
                return(r)
})


df_new$int_groups <- int_groups

ggboxplot(df_new, x = "int_groups", y = "trestbps", 
                title =" Boxplot Grafigi", color = "orange")


df_new %>% group_by(cp, fbs) %>% 
            summarise(Shapiro = shapiro.test(trestbps)$p.value)

bartlett.test(df$trestbps ~ interaction(df$cp, df$fbs))

anova_1 <- aov(df_new$trestbps ~ as.factor(df_new$cp) * as.factor(df_new$fbs))
summary(anova_1)

TukeyHSD(anova_1)

a <- tukey_hsd(anova_1)
View(a)
