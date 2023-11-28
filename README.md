# Bg3Lore
Expanding the scope of the Forgotten Realms lore that is seen in BG3

HOW TO ADD A BOOK

In your copy of the templates replace any occurrence of the words inside ' '. These should be replaced with your unique value/uuid/handle/name etc

In oder to add a book you need
    
    Loca file
        
        An entry inside BgLoreEng.loca.xml for your Book Title 'NEWHANDLE1'- This will be displayed while the book is on the ground and highlighted as well
        
        An entry inside BgLoreEng.loca.xml for your Book's Text Content 'NEWHANDLE2'- This is what we see when we 'use' the book
    
    Root Template
        
        A copy of the template to edit (new file which needs to be renamed DO NOT FORGET TO RE-ADD THE .LSF for multitool conversion)

        A unique UUID/Mapkey 'NEWUUID1'- This is the UUID we will be passing to our object.txt
            <attribute id="MapKey" type="FixedString" value="NEWUUID1"/> <!--Used in Objects.txt-->

        A link to your Book Title 'NEWHANDLE1'- This is what will be displayed on ground or on hover
            <attribute id="DisplayName" type="TranslatedString" handle="NEWHANDLE1" version="1"/>
        
        A link to your book's content UUID which is for simplicity the same as your 'BOOKNAME'    
            <attribute id="BookId" type="FixedString" value="BOOKNAME"/>
        
        OPTIONALLY a value between 0 and 8 for your BookType - This is the background image of the book
            <attribute id="BookType" type="uint8" value="8" />
    
    BGL_Books.lsf.lsx

        A copy of the template to edit (new entry)

        A UUID - For simplicity we keep it the same as 'BOOKNAME'
            <attribute id="UUID" type="FixedString" value="BOOKNAME"/> 

        A link to our books content 'NEWHANDLE2'    
            <attribute id="Content" type="TranslatedString" handle="NEWHANDLE2" value=""/>

    BGL_Object.txt

        A copy of the template to edit (new entry)

        The name of your book in files, for simplicity keep it the same as 'BOOKNAME'
            new entry "BOOKNAME"

        A link to our Root template- this is the 'UUID1' wwe made earlier
            data "RootTemplate" "NEWUUID1"
          
    TreasureTable.txt

        An entry in any teasure table you wish to have you book drop from
            object category "I_BOOKNAME" ,1,0,0,0,0,0,0,0
          