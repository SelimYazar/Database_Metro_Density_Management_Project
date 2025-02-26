CREATE VIEW İstasyonMetroKontrol AS
SELECT 
    i.*,
    m.MetroID,
    m.BeklenenGirişSaati,
    m.GirişSaati,
    m.ÇıkışSaati,
    m.Tarih,
    CASE
        WHEN m.GirişSaati > m.BeklenenGirişSaati THEN 
            CONCAT(dbo.SaatFarkHesabı(m.BeklenenGirişSaati, m.GirişSaati), 'gecikti')
        WHEN m.GirişSaati < m.BeklenenGirişSaati THEN 
            CONCAT(dbo.SaatFarkHesabı(m.GirişSaati, m.BeklenenGirişSaati), 'erken geldi')
		ELSE 'Gecikme Yok'
    END AS Dakiklik,
    dbo.SaatFarkHesabı(m.GirişSaati, m.ÇıkışSaati) AS İstasyondaDurmaSüresi
FROM İstasyon i 
LEFT JOIN İstasyon_Metro m ON i.ID = m.İstasyonID;

SELECT * FROM İstasyonMetroKontrol