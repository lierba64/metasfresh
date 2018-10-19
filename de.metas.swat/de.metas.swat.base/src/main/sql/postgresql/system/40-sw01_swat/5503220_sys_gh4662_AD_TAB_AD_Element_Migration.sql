
-- DROP TABLE IF EXISTS TEMP_Missing_TAB_Element_Names;
CREATE TABLE TEMP_Missing_TAB_Element_Names
AS
SELECT  ad_tab_id, Name, entityType, COALESCE(Description,'') AS Description, COALESCE(help, '') AS Help
FROM AD_Tab tab ;




--DROP TABLE IF EXISTS TEMP_Missing_Tab_Elements_Inserts;

CREATE TABLE TEMP_Missing_Tab_Elements_Inserts
AS
SELECT n.AD_Tab_ID, 

'INSERT INTO AD_ELEMENT (ad_element_id,ad_client_id ,ad_org_id ,isactive ,created ,createdby,updated ,updatedby ,entitytype  ,name , printname , description ,help )' ||
'( SELECT  nextval(' || '''ad_element_seq''' || ') AS AD_Element_ID,  0 AS ad_client_id ,  0 AS ad_org_id ,' || '''Y''' || '  AS isactive ,  now() as created ,  100 AS createdby,  now() AS updated ,  100 AS updatedby , '||

 '''' || COALESCE(n.entityType, '') ||  '''' || ' AS entitytype  ,'||
 '''' ||COALESCE(n.name, '') ||  '''' || ' AS  name ,'||
 '''' || COALESCE(n.name, '') ||  '''' || ' AS  printname ,'||
 '''' ||COALESCE(n.description, '')  ||  '''' || ' AS description ,'||
 '''' ||COALESCE(n.help, '')  ||  '''' || ' AS help );' :: text as INSERT_ELEMENT,

 'UPDATE AD_TAB SET AD_Element_ID = ' || 'currval(''ad_element_seq'') WHERE AD_TAB_ID = ' || n.AD_Tab_ID||';' AS UPDATE_AD_TAB 

 FROM TEMP_Missing_TAB_Element_Names n;