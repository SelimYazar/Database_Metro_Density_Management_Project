CREATE TRIGGER err_trg_PaksIsıkDurumu
ON Vagon
AFTER UPDATE
AS
BEGIN
    BEGIN TRY
        IF UPDATE(YolcuSayısı) OR UPDATE(EngelliYolcuSayısı)
        BEGIN
            UPDATE Paks
            SET 
                IşıkDurumu = 
                    CASE
                        WHEN Geçici.Yoğunluk < 0.4 THEN 'Y'  -- Boş durumu için
                        WHEN Geçici.Yoğunluk BETWEEN 0.4 AND 0.8 THEN 'S'  -- Normal durumu için
                        WHEN Geçici.Yoğunluk > 0.8 THEN 'K'  -- Kalabalık durumu için
                        ELSE 'H' -- Hata durumu için (negatif yoğunluk)
                    END
            FROM Paks
            INNER JOIN inserted i ON Paks.İstasyonID = i.ID
            CROSS APPLY (SELECT CAST(i.YolcuSayısı AS FLOAT) / NULLIF(CAST(i.YolcuKapasitesi AS FLOAT), 0) AS Yoğunluk) AS Geçici
            WHERE Paks.İstasyonID = i.ID;
        END;
    END TRY
    BEGIN CATCH
        -- Hata durumunda, yoğunluk değerini 0 olarak güncelle
        UPDATE Paks
        SET IşıkDurumu = 'Y'  -- Boş durumu için
        FROM Paks
        INNER JOIN inserted i ON Paks.IşıkDurumu = i.ID
        WHERE Paks.İstasyonID = i.ID;
    END CATCH;
END;
