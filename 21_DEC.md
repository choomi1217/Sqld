# <span style="color:#FFBDF5"> 2021년 12월의 기록 </span>

---

> ## 2021-12-1 (수) 🌤

<br/>

화이팅! 

열심히 일하고 있습니다. 그런데 가만 보니 필요없는 데이터를 전달하고 필요없는 데이터를 받는.. 이상한 맵핑을 제가 해놨어요.. 😥
<br/>
반성하고 다음엔 좀 침착하게 짜야겠습니다. <br/>
이 상태라면 다시 개발을 시작하는게 더 나을 정도로 스파게티입니다.
그나마 제가 개발자라 ' 아! 이거 그 부분이구나! ' 하고 넘어가지 안 그랬으면 스파게티에 외계인까지 될 뻔 했습니다! 
### <span style="color:#FFBDF5"> #반성합니다 </span>

점심시간 짬을 내어 해보는 개인 프로젝트!
어제는 css가 먹히지 않아서 애를 먹었는데.. 오늘은 어떻게 될런지..

<br/>
오늘 일하면서 느낀 점<BR/>
파라미터 매핑만 알아보기 쉽게 깔끔하게만 해놔도 스파게티가 어느정도 풀린다!<BR/>
빗질하는 정도?

아무리 해도 git으로 이클립스를 공유하는 방법을 모르겠어요.. 저 많은 파일들을 전부 올리면 깃이 터지지  않을까요

<br/>
시간이 지나면 세션이 폐기 되고 그래서 인터셉터에 걸려서 alertMessage가 날아가는군요

어떻게 세션 발급 시간을 알고 있는거지? 어딘가에 로직이 있나? 했는데 세션 자체가 일정시간동안만 살아있고 그 후엔 사라지는군요!

그건 됐고 그럼 그 세션에 대한 설정은 어디서 하는거지..?

<br/>

###### ~~갑자기 드는 생각인데 칭찬이 받고 싶습니다.. 잘 배운다고~~

<br/>
<br/>
String의 equalsIgnoreCase란 메소드를 봤습니다! 이런 좋은 메소드가 있었습니다!<br/>
저도 모르는 자바의 기능들이 많은거 같아요!

``` java
String str = "abc";
"ABC".equalsIgnoreCase(str);
```

---

> ## 2021-12-2 (목) 🌤

<br/>

커피 마시면서 앉아있었는데 과장님께서 context-common.xml을 개발서버에 적용한다고 쪽지를 보내셔서 ' 그게 무슨 파일이지? ' 싶어서 봤더니 <span style="color:#FFBDF5"> Quarts </span>라고 합니다! <br/>
많이 들어봤고 스케쥴러도 많이 들어봤고 어떤 기능인지 대충은 아는데 <br/>
이 기회에 어떻게 사용하는지 한번 보려고 합니다. <br/>

### QUARTS

쿼츠를 보다가 또 파일업로드 메소드를 봤는데 이게 또 궁금합니당!

이것도 볼래요! 😅

``` javascript

//파일 추가
function goInsert(){
    if($('#selectFile').val()==""){
        $('#selectFile').focus();
        alert("등록할 사진을 선택해주세요.");
        return;
    }
    var ext = $('#selectFile').val().aplit(".").pop().toLowerCase();

    if($.inArray(ext,["gif","jpg","jpeg","png"])==-1){
        alert("gif,jpg,jpeg,png파일만 업로드 가능합니다");
        $('#selectFile').val("");
        return;
    }
    var fileSize = 0;
    var maxSize = 1024*1024;
    try{
        fileSize = document.getElementById("selectFile").files[0].size;
    }catch(exception){
        // ie8 오류 무시
    }
    if(fileSize>maxSize){
        alert("용량이 너무 큽니다. \n 1MB이하로 변경해주세요.");
        return;
    }

    if(!confirm("등록하겠습니까")) return;

    $('#uploadForm').ajaxForm({
        url : "insertImg.do"
        ,type : "POST"
        ,enctype : "multipart/form-data"
        ,dataType : "json"
        ,success : function(result){
            var insResult = eval(result);
            if(insResult.resultMsg == "OK"){
                alert("저장 되었습니다.");
            }
        }
        ,error : function(result){
            //저장실패
        }
    }).submit();

}

//파일 미리보기
function previewImg(targetObj, previewId, width, height){
    
    var preview = document.getElementById(previewId);
    var ua = window.navigator.userAgent;
    //Mozilla/5.0 (Windows NT 10.0; Win62; x64) ...
    
    if(ua.indexOf("MSIE")>-1){ //ie
        targetObj.select();
        try{
            var prevImg = document.getElementById("prev_"+previewId);
            if(prevImg){
                preview.removeChild(prevImg);
            }
            var src = document.selection.createRange().text;
            var img = document.getElementByID(previewId);
            img.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(src='"+src+"', sizingMethod='scale')";
        }catch(e){
            var info = document.createElement("<p>");
            info.innerHtml = "not supported preview";
            preview.insertBefore(info, null);
        }
    }else{ //ie가 아닌 경우
        var files = targetObj.files;
        for(var i=0; i < files.length; i++){
            var file = files[i];
            var imageType = /image.*/; //머야 왜 이따구로 생김
            
            if(!file.type.match(imageType)) continue;
            
            var prevImg = document.getElementById("prev_"+previewId);

            //미리보기 태그 삭제
            if(prevImg){
                preview.removeChild(prevImg);
            }

            //Chrome은 div에 img 뿌리기가 안됨, <img>생성
            var img = document.create Element("img");
            img.id = "prev_" + previewId;
            img.classList.add("obj");
            img.file = file;
            img.style.width = width+'px';
            img.style.height = height+'px';
            preview.appendChild(img);

            if(window.FileReader){
                var reader = new FileReader();
                reader.onloadend = (function(aImg){
                    return function(e){ 
                        //e = ProgressEvent
                        //target: FileReader
                        // ∟ result : "data:image/png;base64,사진 문자열"
                        //timeStamp
                        aImg.src = e.target.result;
                    };
                })(img);
                reader.readAsDataURL(file);
            }else{ //safari -> 사파리는 FileReader를 지원하지 않음
                var info = document.createElement('<p>');
                info.innerHTML = 'not supported preview';
                preview.insertBefore(info, null);
            }

            
        }
    }
}

<div>
    <input type='text' id='fileName' readony='readonly'>
    <input type='file' id='selectFile' onchange='previewImg(this,"upload_photo","600","400" '/>
    <label for='selectFile' class='file_btn' accept='.gif,.png,.jpg,.jpeg,.bmp'>찾아보기</label>
</div>


```

controller
``` java
@RequestMapping(value="/insertImg.do", method=RequestMethod.POST, produces="text/plain; charset=UTF-8")
@ResponseBody
public String controller(HttpServletRequest req, HttpServeltResponse resp) {
    multipartFile multFile;
    MultipartHttpServletRequest mpReq = (MultipartHttpServletRequest)req;
    Iterator fileNameIterator = mpReq.getFileNames();
    try{
        while(fileNameIterator.hasNext()){
            multiFile = mpReq.getFiles((String)fileNameIterator.next());
            service.insertImg(multiFile);
        }
    }catch(Exception e){
        e.printStackTrace;
    }
}
```
service
``` java
public String insertImg(MultipartFile mp){
    if(mp.getSize() > 0){
        this.insertImgFile(mp);
    }
}

private void insertImgFile(MultipartFile file){
    
    String uploadPath = "/where/ever/you/want";
    
    File uploadDir = new File(uploadPatg);

    if(uploadDir.exists()){
        uploadDir.mkdir();
    }

    //파일 풀네임 (파일네임+확장자)
    String orgFileFullName = file.getOriginalFileName();
    //파일네임
    Stirng FileFullName = orgFileFullName.subString(0, StringUtils.lastIndexOf(orgFileFullName,"."));
    
    //파일 확장자
    String fileExt = orgFileFullName.subString(StringUtils.lastIndexOf(orgFileFullName,"."),orgFileFullName.length());
    //서버에 저장될 이름
    String fileName = "서버에 저장하고 싶은 이름 암거나";
    File targetFile = new File(uploadPath, fileName+"."+fileExt);
    
    file.transferTo(targetFile);

    dao.insertImgFile(orgFileFullName);


}
```

잠깐 PM님이 부르셔서 나가서 커피 한잔 하고 왔는데...
ㅓㅇ... 처음부터 끝까지 한번 혼자서 개발 해보라고 하십니다..
배포까지인거 같은데 제가 배포를 한번도 혼자 해본적이 없어서 큰일입니다..


---

> ## 2021-12-3 (금) 🌞

<br/>

아무도 알려주지 않아서 모르겠다는 말은 변명이에요 <br/>
전 여기서 1년동안 아무도 알려주지 않아서 어쩔 수 없구나.. 초보니까 믿고 맡겨주시지 않는구나 했습니다.<br/>
아무도 알려주지 않아도 혼자서 알아가야한다. <br/>
그래서 회사의 모든 접근 가능한 문서를 뒤지고 있습니다. <br/> 
내가 알아갈 정보가 하나라도 있기를 <br/>

제가 일하고 있는 사업단은 지리정보를 기반으로 운영되는 사업단입니다.
세상에 저는 openLayers가 있다와 어느정도 뭐가 뭔지 대충 알고만 있으면 되겠지 싶었습니다만..
.shp 파일은 처음 봅니다.
그래서 알게 된 김에 .shp 파일에 대해서 조금 적어 가볼까 합니다.

###### 참고자료
###### [위키백과](https://en.wikipedia.org/wiki/Shapefile)
<br/>

## .shp : ShapeFile
지리적 위치 및 관련 속성 정보를 저장하기 위한 디지털 벡터 저장 형식입니다.


---

> ## 2021-12-6 (월) 🌞

반성할 일이 생겼습니다.. <br/>
저번주부터 열심히 공부하고 일 해놓고는 커밋을 이틀 연속으로 까먹었습니다. 😥

오늘 DBian 카페의 글을 보다가 오프라인 강의를 보았습니다.
59만원정도 했는데 신청했습니다.<BR/>
아직 결제는 안 했지만.. 할부가 되면 좋겠군요..😂

저는 오늘 SQL문을 들여다 볼 예정입니다!

오라클의 옵티마이저가 정말 궁금해서 <br/>
[DBian 옵티마이저](https://cafe.naver.com/dbian/4385)
참고해서 공부하고 있습니다.

제 쿼리가 느리단 얘기는 계속 듣고 있고 이를 고쳐보고 싶어서 여러방면으로 노력중입니다.
현재 ORACLE의 HINT라는 기능을 살펴보고 있습니다.

현재 제 쿼리는 3개의 테이블을 JOIN 중입니다! <br/>
그래서 이 JOIN의 순서를 바꿔주는 HINT를 찾은거 같습니다!

과장님께서 이제 곧 없어질 홈페이지지만 수정할 부분 하나만 수정해달라고 하셔서.. 
과장님께서 주신 이클립스 압축파일을 풀었는데.. 오류투성이입니다.. 환경설정 안 해도 되도록 전부 압축해서 주셨다는데.. 😅😅

그렇게 과장님이 주신 과제 하다가 신기한걸 봤습니다!
개발자센터라고 따로 개발자들을 위한 API를 제공하는 페이지에서 발견한 코드입니다!

```javascript

var xmlHttp;

function first(){
    var url = "/***.do?***=***";
    createXmlHttp();
    xmlHttp.onreadystatechange = handlerStateMonthChangeFile; // 뭐야 이거 함수였어
    xmlHttp.open("GET", url, true);
    xmlHttp.send(null);
}

function createXmlHttp(){
    if(xmlHttp!=null){
        xmlHttp.abort();
        delete xmlHttp;
        xmlHttp = null;
    }
    if(window.ActiveXObject){
        xmlHttp = xmlVersionCheck();
    }else if(window.XMLHttpRequest){
        xmlHttp = new XMLHttpRequest();
    }
}
function xmlVersionCheck(){
    var version = ["Msxm12.XMLHTTP.6.0","Msxml12.XMLHTTP.3.0","Microsoft.XMLHTTP"];
    for(var data in version){
        try{
            var xmlDom = new ActiveXObject(version[data]);
            return xmlDom;
        }carch(ex){}
    }
    return null;
}

function handlerStateMonthChangeFile(){
    if(xmlHttp.readyState==4){
        if(xmlHttp.status==200){
            var a = xmlHttp.responseXML.getElementByTagName('a');
            var arr = xmlHttp.responseXML.getElementByTagName('b');
            console.log(arr[0]); // xmlHttp에 담겨오는 XML은 ARRAY도 가능합니다
        }
    }
}

```
[XMLHttpRequest | 참고](https://developer.mozilla.org/en-US/docs/Web/API/XMLHttpRequest/readyState)

URL을 타고 들어가면 XML파일이 나옵니다 거기서 TAG들을 끌어와 쓰는 로직입니다.

대단해요.. 이런걸 어떻게 만드는건지...



---

> ## 2021-12-7 (화) 🌞

현재 진행중인 프로젝트 
1. 내 블로그 (jquery, spring, tomcat, oracle)
2. 선거구 획정 프로그램 (jquery, spring, tomcat, geoserver, postgre)

web.xml -> welcom-file -> login.do -> UserController.java 

loginProcess.do (로그인 판별) -> 로그인 성공시 -> opertList.do

이 프로젝트에선 암호화 알고리즘을 SHA-256 을 사용합니다.
spring security, aria만 쓰다가 sha는 처음 보는거 같아요.

항공지도 
http://210.117.198.120:8081/o2map/services?service=WMTS&request=GetTile&version=1.0.0&layer=AIRPHOTO&style=_null&format=image/jpg&tilematrixset=NGIS_AIR&tilematrix=17&tilerow=15317&tilecol=9188&apiKey=1482BA6C941C4BA57FD8CDA5CFF4C3AE

기본지도
http://localhost:8085/openapi/Gettile.do?service=WMTS&request=GetTile&version=1.0.0&layer=korean_map&style=korean&format=image/png&tilematrixset=korean&tilematrix=L17&tilerow=15320&tilecol=9194&apikey=1482BA6C941C4BA57FD8CDA5CFF4C3AE

백지도
http://localhost:8085/openapi/Gettile.do?service=WMTS&request=GetTile&version=1.0.0&layer=white_map&style=korean&format=image/png&tilematrixset=korean&tilematrix=L17&tilerow=15318&tilecol=9191&apikey=1482BA6C941C4BA57FD8CDA5CFF4C3AE

GeoServer 다운로드 위치 
C:\Program Files (x86)\GeoServer 2.8.5

###### ~~나는 아무것도 하는 일이 없다.. 내가 이 무시들 다 버텨낸다 내가 진짜.. 내가 여기 사업단 기술 다 배워서 이직한다 진짜.. 눈물나요.. 팀장님이 이것저것 말 걸다가 마저 쉬세요 하는데.. 나 일하려고 여기 왔는데 어이없어서 눈물납니다.~~

<br/>
<br/>

<img src="./img/1207_1.png">

js와 css 못찾은 이유를 찾았습니다!
WEB-INF 안에 있던 정적문서들을 webapp 아래로 옮겼더니 해결 됐습니다.

* 문제 1
    - 인코딩 에러 발견
* 해결 1
    - jsp에 인코딩 태그
    - encodingfilter 설정
``` JSP

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

```
```xml
    <filter>
		<filter-name>encodingFilter</filter-name>
		<filter-class>org.springframework.web.filter.CharacterEncodingFilter</filter-class>
		<init-param>
			<param-name>encoding</param-name>
			<param-value>utf-8</param-value>
		</init-param>
	</filter>
	<filter-mapping>
		<filter-name>encodingFilter</filter-name>
		<url-pattern>*.do</url-pattern>
	</filter-mapping>
```


[ 지시자 : <%@   %> ]

JSP 페이지가 컨테이너에게 필요한 메세지를 보내기 위한 태그 <br/>
page : JSP 페이지의 전체적인 속성을 지정 <br/>
include : 다른 페이지를 현재 페이지에 삽입 <br/>
taglib : 태그라이브러리의 태그 사용 <br/>
범위 : JSP 파일 전체 (클래스를 import 할 경우 파일 내 어디서든 접근할 수 있음) <br/>

``` jsp
<%@ page import="java.util.Arrays"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
 ```

page는 대부분 import나 에러 페이지 삽입 등의 용도로 많이 사용

[참고](https://codevang.tistory.com/197)


* 문제 2
    - javascript function이 찾아지지 않는 문제 발견
* 해결 2
    - jquery 가져오는 ```<script>``` 를 제대로 닫지 않아서 생긴 문제
    


