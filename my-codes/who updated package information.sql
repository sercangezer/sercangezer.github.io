910	F98826	UP	30	5	Package Deployment on Servers Information	Master Files	H96B: Package Build	System Tables
http://www.jdetables.com/?schema=910&system=H96B&table=F98826


-- Bütün veriler
SELECT * FROM SY910.F98826

-- Lazım olan columns
UPJDEPKGNM - Name - Package	
UPPATHCD - Code - Path	
UPJOBN	- Work Station ID	
UPUSER	- User ID	
UPDEPLDATE	-Effective Date	
UPDEPLTIME	- Effective Time	

-- Sisteme bütün paket atanlar sondan başa sıralı olarak
SELECT UPDEPLDATE, UPDEPLTIME, UPJDEPKGNM, UPPATHCD, UPUSER, UPJOBN FROM SY910.F98826 
ORDER BY UPDEPLDATE desc, UPDEPLTIME desc

-- Canlı ortamda(PD910) SGEZER kullanıcısı dışında paket atanlar 
SELECT jde_to_tarih(UPDEPLDATE), UPDEPLTIME, UPJDEPKGNM, UPPATHCD, UPUSER, UPJOBN FROM SY910.F98826 
where
UPUSER <>'SGEZER' AND UPPATHCD ='PD910'
ORDER BY UPDEPLDATE desc, UPDEPLTIME desc 