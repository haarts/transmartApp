--Populate the SEARCH_TAXONOMY tree with the categories we want to see.
INSERT INTO SEARCH_TAXONOMY (TERM_NAME) VALUES ('Categories');
INSERT INTO SEARCH_TAXONOMY (TERM_NAME) VALUES ('Analyses');
INSERT INTO SEARCH_TAXONOMY (TERM_NAME) VALUES ('Study');
INSERT INTO SEARCH_TAXONOMY (TERM_NAME) VALUES ('Region of Interest');
INSERT INTO SEARCH_TAXONOMY (TERM_NAME) VALUES ('Data Type');

--Add a record which makes 'Categories' the top level node.
INSERT INTO SEARCH_TAXONOMY_RELS (CHILD_ID) VALUES (SELECT TERM_ID FROM SEARCH_TAXONOMY WHERE TERM_NAME = 'Categories');
INSERT INTO SEARCH_TAXONOMY_RELS (CHILD_ID,PARENT_ID) SELECT (SELECT TERM_ID FROM SEARCH_TAXONOMY WHERE TERM_NAME = 'Analyses'),(SELECT TERM_ID FROM SEARCH_TAXONOMY WHERE TERM_NAME = 'Categories') FROM DUAL;
INSERT INTO SEARCH_TAXONOMY_RELS (CHILD_ID,PARENT_ID) SELECT (SELECT TERM_ID FROM SEARCH_TAXONOMY WHERE TERM_NAME = 'Study'),(SELECT TERM_ID FROM SEARCH_TAXONOMY WHERE TERM_NAME = 'Categories') FROM DUAL;
INSERT INTO SEARCH_TAXONOMY_RELS (CHILD_ID,PARENT_ID) SELECT (SELECT TERM_ID FROM SEARCH_TAXONOMY WHERE TERM_NAME = 'Region of Interest'),(SELECT TERM_ID FROM SEARCH_TAXONOMY WHERE TERM_NAME = 'Categories') FROM DUAL;
INSERT INTO SEARCH_TAXONOMY_RELS (CHILD_ID,PARENT_ID) SELECT (SELECT TERM_ID FROM SEARCH_TAXONOMY WHERE TERM_NAME = 'Data Type'),(SELECT TERM_ID FROM SEARCH_TAXONOMY WHERE TERM_NAME = 'Categories') FROM DUAL;

--Add a record to SEARCH_KEYWORD for the GWAS data type.
INSERT INTO SEARCH_KEYWORD (KEYWORD,UNIQUE_ID,DATA_CATEGORY,DISPLAY_DATA_CATEGORY) VALUES ('GWAS','FACETED:DAT:GWAS','DATA_TYPE','Data Type');

--Add a record to SEARCH_TAXONOMY for the GWAS data type.
INSERT INTO SEARCH_TAXONOMY (TERM_NAME,SEARCH_KEYWORD_ID) SELECT 'GWAS',(SELECT SEARCH_KEYWORD_ID FROM SEARCH_KEYWORD WHERE KEYWORD = 'GWAS') FROM DUAL;

--ADD A RECORD TO THE BIO_ANALYSIS_ATTRIBUTE TABLE THAT ASSOCIATES THE GWAS DATA_TYPE WITH THIS ANALYSIS.
INSERT INTO BIOMART.BIO_ANALYSIS_ATTRIBUTE (STUDY_ID,BIO_ASSAY_ANALYSIS_ID,TERM_ID,SOURCE_CD) SELECT '169381',1147409,(SELECT TERM_ID FROM SEARCH_TAXONOMY WHERE TERM_NAME = 'GWAS'),'DATA_TYPE:GWAS' FROM DUAL;
