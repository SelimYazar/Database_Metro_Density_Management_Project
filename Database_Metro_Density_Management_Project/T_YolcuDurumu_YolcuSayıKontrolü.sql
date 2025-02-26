--Hem Yoğunluk durumunu hem de yolcu sayısının negatif değere düşmemesini (Kamera giren yolcuları düzgün tespit edemezse diye) sağlıyor.
CREATE TRIGGER YoğunlukDurumu
ON Vagon
AFTER UPDATE
AS
BEGIN
	IF UPDATE(YolcuSayısı)
	BEGIN
		UPDATE Vagon
		SET 
		YolcuSayısı = CASE WHEN Vagon.YolcuSayısı < 0 THEN 0 ELSE Vagon.YolcuSayısı END,
		EngelliYolcuSayısı = CASE WHEN Vagon.EngelliYolcuSayısı < 0 THEN 0 ELSE Vagon.EngelliYolcuSayısı END,
		Vagon.YolcuYoğunluğu = 
			CASE
				WHEN Geçici.Yoğunluk < 0.4 THEN 'Boş'
				WHEN Geçici.Yoğunluk BETWEEN 0.4 AND 0.8 THEN 'Normal'
				WHEN Geçici.Yoğunluk > 0.8 THEN 'Kalabalık'
			END
		FROM (SELECT ID, CAST(inserted.YolcuSayısı AS FLOAT) / CAST(inserted.YolcuKapasitesi AS FLOAT) AS Yoğunluk FROM inserted) AS Geçici
		WHERE Vagon.ID = Geçici.ID;
	END;
END;
DROP TRIGGER YoğunlukDurumu