/***********************************************/
/**                                            */
/**              MINI-PROJET JS 2015           */
/**                                            */
/***********************************************/

/** placez ici votre code javascript réponse aux questions du sujet de projet */

/** n'oubliez pas de faire précéder le code de vos fonctions 
    d'un commentaire documentant la fonction                   **/


    var img=new Image();
    img.src="images/vaisseau-ballon-petit.png";
    window.onload=function(){
    	var c=document.getElementById("stars");
    	var ctx=c.getContext("2d");
    	ctx.drawImage(img,40,200);
   
    };