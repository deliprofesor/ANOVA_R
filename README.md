# ANOVA_R

Data manipulation - Veri Manipülasyonu

Data manipulation is the process of organizing, filtering, transforming, or restructuring data during the data analysis process. Purpose of Data Manipulation:

Increase the understandability of the dataset
Cleanse unnecessary information
Prepare it for analysis / present it in a suitable format for specific analysis techniques
These R codes perform statistical analysis on a dataset named "heart.csv." The analysis utilizes R packages such as tidyverse, rstatix, and ggpubr.

Tidyverse simplifies data manipulation through the dplyr package. You can perform operations like filtering, sorting, grouping, summarizing, and transforming on data frames quickly and effectively.

Rstatix is used for basic statistical tests such as t-tests (independent sample t-test, paired sample t-test, etc.), ANOVA (one-way, two-way, analysis of variance), Mann-Whitney U test, Kruskal-Wallis test, etc. It also handles multiple comparisons, applying techniques like Tukey HSD test, Bonferroni correction, etc.

Ggpubr, derived from ggplot2, makes it easier to create various types of plots (scatter plots, box plots, line plots, etc.) and provides additional functions to customize these plots.

The dataset is read from the "heart.csv" file, containing various features related to heart diseases.

ANOVA (Analysis of Variance) is a method used to evaluate differences in variance between groups in statistical analyses. It is often used to determine if the means between groups are statistically significantly different. ANOVA is an important tool for understanding the reasons for differences between groups and for making comparisons between groups.

The basic principle of ANOVA is to partition the total variability between groups into within-group variability and between-group variability. This helps assess whether the differences between groups are random or genuinely significant.

ANOVA is typically used in the following cases:

Comparison Between Three or More Groups: It is used to examine differences among three or more groups, not just between two groups.
Impact of Categorical Independent Variables: It is used to assess the effect of a categorical independent variable (factor) on a dependent variable. For example, it can be used to examine the effect of different doses of a drug on disease symptoms.
Evaluation of Group Variances: It is used to determine if the variances between groups are significant. If the variance between groups is statistically significant, it suggests there is a difference between the groups.
ANOVA comes in different types, usually one-way ANOVA (one factor) and two-way ANOVA (two factors). One-way ANOVA examines the effect of one factor, while two-way ANOVA assesses the effects and interactions of two factors.

Tukey HSD (Honestly Significant Difference) is a multiple comparison test used to determine significant differences between groups in statistical analyses. It is often used in conjunction with ANOVA to identify which groups differ significantly from each other. This test is conducted after an ANOVA test identifies a significant difference between groups. Tukey HSD test helps determine which groups are different from each other by providing p-values indicating significant mean differences between groups.

Statistical Analyses

Two-Way Analysis of Variance (ANOVA): The analysis was performed using the code 'anova_1 <- aov(df$chol ~ as.factor(df$cp) * as.factor(df$fbs)).' The results were summarized using 'summary(anova_1).'
rstatix Usage: The analysis conducted with 'anova_test(df, dv= chol, between = c(cp, fbs))' did not yield significance.
Tukey HSD Test: The analysis results using 'TukeyHSD(anova_1)' were visualized with 'a <- tukey_hsd(anova_1).'
Boxplot Graphs: Comparisons of trestbps values among different groups were made using 'ggboxplot' functions.
Outlier Detection: Outliers in the trestbps variable were identified using the 'identify_outliers(heart["trestbps"])' function. A new dataset was created by removing outliers ('df_new'). Comparisons of trestbps values between groups were made using 'ggboxplot' and 'TukeyHSD.'

Kalp Sağlığı Verisinde İki Yönlü ANOVA Analizi:
Bu proje, kalp sağlığı ile ilgili bir veri seti üzerinde iki yönlü ANOVA (Analysis of Variance) analizi gerçekleştirmek için kullanılan R kodunu ve süreçlerini içermektedir. Çalışmada, farklı göğüs ağrısı türleri (cp) ve açlık kan şekeri durumlarına (fbs) bağlı olarak kolesterol (chol) ve dinlenme kan basıncı (trestbps) değişkenlerindeki farkların istatistiksel olarak anlamlı olup olmadığı incelenmiştir.

Kullanılan Kütüphaneler
Analiz sürecinde aşağıdaki R kütüphaneleri kullanılmıştır:

1) Tidyverse, dplyr paketi aracılığıyla veri manipülasyonunu kolaylaştırır. Veri çerçeveleri üzerinde filtreleme, sıralama, gruplama, toplama ve dönüştürme gibi işlemleri hızlı ve etkili bir şekilde yapabilirsiniz.

2)rstatix, t-testleri (bağımsız örneklem t-testi, eşleştirilmiş örneklem t-testi vb.), ANOVA (tek yönlü, iki yönlü, varyans analizi), Mann-Whitney U testi, Kruskal-Wallis testi gibi temel istatistiksel testleri yapmak için kullanılır.Çoklu Karşılaştırmalar: Gruplar arasında çoklu karşılaştırmalar yapmak için kullanılır.Tukey HSD testi, Bonferroni düzeltmesi gibi çoklu karşılaştırma tekniklerini uygular.

3)ggpubr, ggplot2'den türetilmiş farklı grafik türlerini (yayılım diyagramları, kutu grafikleri, çizgi grafikleri vb.) daha kolay oluşturmayı sağlar ve bu grafik türlerini özelleştirmek için ek işlevler sunar.

library(tidyverse)
library(rstatix)
library(ggpubr)

Veri Seti
Veri, kalp sağlığı ile ilgili değişkenleri içermektedir. Önemli değişkenler:

cp: Göğüs ağrısı türleri (kategorik).
fbs: Açlık kan şekeri durumu (kategorik).
chol: Kolesterol seviyeleri (sayısal).
trestbps: Dinlenme kan basıncı (sayısal).
Veri seti, dosyadan aşağıdaki komut ile okunmuştur:

R
Kodu kopyala
heart <- read.csv("/home/yorgun/r_tube/Rcode/ANOVA-MANOVA/heart.csv")
View(heart)
Adımlar
1. Veri Filtreleme
Kolesterol değerleri 400'ün altında olan bireyler incelendi. Bu, uç değerlerin analiz sonuçlarını etkilemesini önlemek için yapılmıştır.

R
Kodu kopyala
df <- heart %>% filter(chol < 400)
2. Normallik ve Varyans Homojenliği Testleri
Shapiro-Wilk Testi: Normallik testi.
Bartlett Testi: Varyansların homojenliğini kontrol eder.
R
Kodu kopyala
df %>% group_by(cp, fbs) %>% summarise(Shapiro = shapiro.test(chol)$p.value)
bartlett.test(df$chol ~ interaction(df$cp, df$fbs))
3. İki Yönlü ANOVA
Kolesterol Üzerinde İki Yönlü ANOVA
Farklı göğüs ağrısı türleri ve açlık kan şekeri durumlarının kolesterol seviyelerine etkisi incelendi:
R
Kodu kopyala
anova_1 <- aov(df$chol ~ as.factor(df$cp) * as.factor(df$fbs))
summary(anova_1)
Dinlenme Kan Basıncı Üzerinde İki Yönlü ANOVA
Benzer analiz, dinlenme kan basıncı için tekrarlandı:
R
Kodu kopyala
anova_1 <- aov(df$trestbps ~ as.factor(df$cp) * as.factor(df$fbs))
summary(anova_1)
4. Tukey HSD Post-Hoc Testi
ANOVA sonucunda anlamlı farklılık bulunan gruplar için Tukey HSD testi ile detaylı analiz yapıldı.

R
Kodu kopyala
TukeyHSD(anova_1)
a <- tukey_hsd(anova_1)
View(a)
5. Grafikler
Boxplot Grafikler ile gruplar arasındaki farklar görselleştirildi:

Kolesterol için:
R
Kodu kopyala
ggboxplot(df, x = c("cp", "fbs"), y = "chol")
Dinlenme kan basıncı için, gruplar birleştirilerek özel bir görselleştirme yapıldı:
R
Kodu kopyala
int_groups <- apply(df_new, MARGIN = 1, FUN = function(x){
                r <- paste0(x["cp"], ' - ', x["fbs"])
                return(r)
})
df_new$int_groups <- int_groups

ggboxplot(df_new, x = "int_groups", y = "trestbps", 
                title ="Boxplot Grafigi", color = "orange")
Sonuçlar
Normallik ve varyans homojenliği testleri, analiz için gerekli varsayımların sağlandığını gösterdi.
İki yönlü ANOVA sonuçları:
Kolesterol üzerinde anlamlı bir etkileşim bulunamadı.
Dinlenme kan basıncı üzerinde anlamlı farklar gözlemlendi.
Post-hoc test sonuçları, hangi gruplar arasında farklılık olduğunu ortaya koydu.

Veri manipülasyonu
veri analizi sürecinde verilerin düzenlenmesi, filtrelenmesi, dönüştürülmesi veya yeniden yapılandırılması işlemidir.
Veri Manipülasyonun Amacı:
-Veri setinin anlaşılabilirliğini artırmak
-Gereksiz bilgileri temizlemek
-Analiz için uygun hale getirmek / belirli analiz tekniklerine uygun formatta sunmak


 
Veri seti "heart.csv" dosyasından okunmuştur. Bu veri seti kalp hastalıklarıyla ilgili çeşitli özellikleri içerir.

ANOVA (Analysis of Variance)
ANOVA (Analysis of Variance), istatistiksel analizlerde gruplar arasındaki varyans farklarını değerlendirmek için kullanılan bir yöntemdir. Genellikle gruplar arasındaki ortalamaların istatistiksel olarak anlamlı bir şekilde farklı olup olmadığını belirlemek için kullanılır. ANOVA, gruplar arasındaki farklılıkların nedenlerini anlamak ve gruplar arasında karşılaştırmalar yapmak için önemli bir araçtır.

ANOVA'nın temel prensibi, gruplar arasındaki toplam değişkenliğin, grup içi değişkenliğe ve gruplar arası değişkenliğe ayrılmasıdır. Bu sayede gruplar arasındaki farklılıkların rastgele mi yoksa gerçekten anlamlı mı olduğu değerlendirilir.

ANOVA genellikle şu durumlarda kullanılır:

1) Üç veya Daha Fazla Grup Arasında Karşılaştırma: İki grup arasındaki farkı değil, üç veya daha fazla grup arasındaki farkları incelemek için kullanılır.
2) Kategorik Bağımsız Değişkenlerin Etkisi: Kategorik bir bağımsız değişkenin (faktör) bağımlı bir değişken üzerindeki etkisini değerlendirmek için kullanılır. Örneğin, bir ilacın farklı dozlarının hastalık belirtileri üzerindeki etkisini incelemek için kullanılabilir.
3) Gruplar Arasındaki Varyansın Değerlendirilmesi: Gruplar arasındaki varyansın anlamlı olup olmadığını belirlemek için kullanılır. Eğer gruplar arasındaki varyans istatistiksel olarak anlamlı ise, gruplar arasında bir fark olduğu düşünülür.

ANOVA, genellikle tek yönlü ANOVA (bir faktör) ve iki yönlü ANOVA (iki faktör) olmak üzere farklı türleri bulunur. Tek yönlü ANOVA'da bir faktörün etkisi incelenirken, iki yönlü ANOVA'da iki faktörün etkisi ve etkileşimi değerlendirilir.

Tukey HSD (Honestly Significant Difference)
Tukey HSD (Honestly Significant Difference), istatistiksel analizlerde gruplar arasındaki anlamlı farkları belirlemek için kullanılan bir çoklu karşılaştırma testidir. Genellikle ANOVA (Analysis of Variance) gibi gruplar arası farklılık testlerinde ortaya çıkan anlamlı sonuçların hangi gruplar arasında olduğunu belirlemek için kullanılır. Bu test, gruplar arasındaki ortalama farklılıklarının anlamlı olup olmadığını değerlendirmek için önce ANOVA testi yapılır. ANOVA testi sonucunda gruplar arasında istatistiksel olarak anlamlı bir fark olduğu tespit edilirse, Tukey HSD testi kullanılarak hangi grupların birbirinden farklı olduğu belirlenir.

Tukey HSD testi, grupların birbirinden farklı olduğunu gösteren p-değerleriyle birlikte gruplar arasındaki ortalama farklılıklarının ölçüsünü de verir. Bu sayede gruplar arasındaki farklılıkların istatistiksel olarak anlamlı olup olmadığına ve hangi grupların farklı olduğuna dair daha sağlam bir bilgi elde edilir.

İstatistiksel Analizler
1)İki Yönlü Varyans Analizi (ANOVA): anova_1 <- aov(df$chol ~ as.factor(df$cp) * as.factor(df$fbs)) kodu ile yapılmıştır. Sonuçları summary(anova_1) ile özetlenmiştir.
2)rstatix Kullanımı: anova_test(df, dv= chol, between = c(cp, fbs)) ile yapılan analizde anlamlılık elde edilmemiştir.
3)TukeyHSB Testi: TukeyHSD(anova_1) ile yapılan analiz sonuçları a <- tukey_hsd(anova_1) ile görselleştirilmiştir.
4) Boxplot Grafikleri: ggboxplot fonksiyonları kullanılarak çeşitli gruplar arasındaki trestbps değerlerinin karşılaştırılması yapılmıştır.

Outliner Tespiti = 'identify_outliers(heart["trestbps"])' fonksiyonu ile trestbps değişkenindeki aykırı değerler belirlenmiştir.
Yeni veri seti oluşturma = Aykırı değerler çıkarılarak yeni bir veri seti oluşturulmuştur ('df_new').
'ggboxplot' ve 'TukeyHSD' kullanılarak gruplar arası trestbps değerlerinin karşılaştırmaları yapılmıştır.

