1. The application is created in visual studio 2010.
2. The application is developed in asp.net, vb.net, bootstrap, jQuery, Web Services (ASMX Based) and MySQL.
3. I used the open source database MySQL for stroing the data.
4. All the database access are done through web method calls.
5. As instructed, All the states were listed.
6. On selecting a particular state, the corrresponding cities were listed.
7. On selection of the city, the corresponding station code and the predicted air speed for the selected date will be displayed
8. By default, the current date is displayed in the date textbox. The user can change it.
9. Link is provided next to date textbox. On clicking it, the last 10 Days details will be displayed in a popup.
10. On entering the Actual Speed, the variance will be calculated and the color will be changed as per the rule provided as below,
        +-1                   ->  Black
	+-3                   -> Purple
	Below -5 and Above 5  -> Red
11. Web service call provided to pass the predicted air speed. URL : http://localhost:60072/services.asmx/putpredicted?station_code=AS-GU-01&air_speed=20
	Note : The air speed will be updated for the current date.
12. Database file has been added into the folder Database. You can download and restore it.