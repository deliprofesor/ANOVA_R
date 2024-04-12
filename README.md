# ANOVA_R
Veri manipülasyonu
veri analizi sürecinde verilerin düzenlenmesi, filtrelenmesi, dönüştürülmesi veya yeniden yapılandırılması işlemidir.
Veri Manipülasyonun Amacı:
-Veri setinin anlaşılabilirliğini artırmak
-Gereksiz bilgileri temizlemek
-Analiz için uygun hale getirmek / belirli analiz tekniklerine uygun formatta sunmak

Bu R kodları, "heart.csv" adlı bir veri seti üzerinde istatistiksel analizler yapar. Analizlerde tidyverse, rstatix, ve ggpubr gibi R paketleri kullanıldı.
-- Tidyverse, dplyr paketi aracılığıyla veri manipülasyonunu kolaylaştırır. 
Veri çerçeveleri üzerinde filtreleme, sıralama, gruplama, toplama ve dönüştürme gibi işlemleri hızlı ve etkili bir şekilde yapabilirsiniz.
-- rstatix, t-testleri (bağımsız örneklem t-testi, eşleştirilmiş örneklem t-testi vb.), ANOVA (tek yönlü, iki yönlü, varyans analizi), Mann-Whitney U testi, Kruskal-Wallis testi gibi temel istatistiksel testleri yapmak için kullanılır.Çoklu Karşılaştırmalar: Gruplar arasında çoklu karşılaştırmalar yapmak için kullanılır.Tukey HSD testi, Bonferroni düzeltmesi gibi çoklu karşılaştırma tekniklerini uygular.
-- ggpubr, ggplot2'den türetilmiş farklı grafik türlerini (yayılım diyagramları, kutu grafikleri, çizgi grafikleri vb.) daha kolay oluşturmayı sağlar ve bu grafik türlerini özelleştirmek için ek işlevler sunar.
 
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

