# ????

매일 헷갈리는 나를 위한 git 사용법 <br>
https://rogerdudler.github.io/git-guide/index.ko.html

> ## 2021-11-10


### 1.

 iframe을 통해 엑셀 파라미터를 보내는 방식이었습니다. <br/>
엑셀 다운로드 버튼을 누르면 JS에서 아이프레임으로 파라미터를 넘기는 방식이었는데 파라미터가 보내지기는 하지만 처음 보낸 파라미터가 다음 전송시에도 바뀌지 않고 중복해서 보내지는 문제가 있었습니다. <br/>
첫번째로 확인 했던 부분은 ```@RequestParam```입니다. <br />
```@RequestParam```이 초기화가 안 되는줄 알았습니다. <br/>
혹은 어디선가 같은 변수 이름으로 전역변수를 사용하고 있고 그래서 계속 전역변수를 호출 하는줄 알았습니다.<br/>
그렇게 ```@RequestParam```을 살펴보는 삽질을 하던 중<br/>
대리님께서 iframe을 손수 remove 해야 한다는 힌트를 주셨습니다.
``` javascript
if($('iframe')!=undefined){
    $('iframe').remove();
}
```
덕분에 잘 해결했습니다. 😄

### 2.

```jsp
<%@ taglib prefic='fn' uri='jstl/functions' %>
```
이게 도대체 모징?

<br/>


---

> ## 2021-11-15 (월)

### 1. 
지금까지 안돼서 애 먹었던 manifest.xml 파일 오류를 해결했습니다.
해결한 코드는 아래입니당.

```xml
<application
        android:allowBackup="true"
        android:icon="@mipmap/ic_launcher"
        android:label="My First App"
        android:roundIcon="@mipmap/ic_launcher_round"
        android:supportsRtl="true"
        android:theme="@style/Theme.MyFirstApp">
        <activity android:name=".MainActivity"
            android:exported="true">
            <intent-filter>
                <action android:name="android.intent.action.MAIN"/>
                <category android:name="android.intent.category.LAUNCHER"/>
            </intent-filter>
        </activity>
    </application>
```
applicatiob 안에는 원래 activity도 intent-filter도 없었는데 이 둘을 추가해서 해결했습니다.

그 중에서도 activity에 ``` android:exported="true" ``` 를 꼭 해줘야 한다고 합니다.

---

> ## 2021-11-17 (수)

오늘 지금까지 시험삼아 개발했던 인접시군구 영향도 라는 기능을 다시 실행시켰더니 갑자기 오류가 납니다. <br />
얼마전까진 참 잘 됐던거 같은데.. <br /> 
분명 값을 가져와야하는 상황인데 undefined이라고 뜨는 상황입니다.<br/>
이 undefined에 대한 처리가 부족한 것 같습니다.. <br/>
어떻게 해야 이런 예외상황에 잘 대처할 수 있는지.. 잘 모르겠습니다,,

오후근무시간중 마주친 이상한일 <BR/>
데이터가 들어와서 가는 테이블은 한 곳인데<BR/>
왜? 웹으로 출력할 땐 테스트한 데이터가 안 보이는거지? 어떻게 한걸까요?

내가 추측컨데 들어올때 
WEB.XML -> DISPATCHER-SERVLET.XML -> InterceptorHandlelingController.java 
이렇게 오면서 테스트서버와 테스트서버가 아닌걸 판가름하고

DB서버를 다르게 태워 보내는 방식인건가

---

> ## 2021-11-18 (목)

어제 조대리님께서 알려주신 방법을 써보자! 홧팅! 아자아자! <BR/>
하려다가 시험이 이틀 남았던걸 깨달았고 아치 싶어서 급하게 시험공부에 돌입했습니다. <BR>
이번 시험이 끝나면 할 일들이 많아요.<BR/>
리스트로 나열 해보자면 <BR/>
1. 업무구조도, INSERT와 UPDATE 류차장님 소스 노려보면서 내꺼 수정하기
2. 시군구 영향도 조회, 조대리님 소스 노려보면서 내꺼 수정하기
3. 다음 시험 일정 알아보기 (떨어질게 뻔하니까.. 괜찮아!!)
4. 삼성 노트북 포맷하고 이클립스, SQLdeveloper, VSC 환경설정 다시 하기

---

> ## 2021-11-19 (금)

오늘 공부하면서 오라클에서 행을 열로 반환해주는 PIVOT이란 기능을 봤습니다<BR/>
11G부터 지원하는 기능이라는데 그 전에는 DECODE를 이용해 행을 열로 반환했다고 합니다.<BR/>
오늘 회사에 가서 DECODE를 이용해 행을 열로 반환한 쿼리가 있는지 구경할 예정입니다!















