# <span style="color:#FFBDF5"> 2022년 1월 </span>

---

> ## 2022-1-1 (토) 🌤

## start

- spring-boot
- gradle
- docker
- aws
- sqlp
- oracle
- intellij
- 정보보안기사
- 운동


## spring boot

[스프링 참고 페이지](https://docs.spring.io/spring-boot/docs/2.5.8/reference/html/features.html#features)


### Thymeleaf
spring-boot에서는 jsp를 사용하지 않고 thymeleaf 같은 template engine을 씁니다.

[ 왜 thymeleaf를 쓰는가 ](https://velog.io/@dsunni/Spring-Boot-%EC%8A%A4%ED%94%84%EB%A7%81-%EC%9B%B9-MVC-Thymeleaf)

spring-boot 동작환경 그림

<img src = './img/0102_1.jpg'>

컨트롤러에서 리턴 값으로 문자를 반환하면 뷰리졸버가 화면을 찾아가서 처리합니다.
* 스프링부트 템플릿엔진 기본 viewName 매핑
* `resources:templates/` + {viewName} + `.html`

스프링부트의 템플릿이 들어가는 위치

<img src = './img/0102_2.png'>



---

> ## 2022-1-5 (수) 🌤

<br/>

<img src = './img/0105_1.png'>

D:\study\hello-spring\hello-spring <br/>
자신의 워크스페이스에서 ``` gradlew build ``` 를 실행합니다.

실행하면 그래들이 필요한 라이브러리를 다운받아주고 

build\libs 에 .jar 파일이 생깁니다.

이 jar 파일을 ``` java -jar ****.jar  ``` 로 실행합니다.
그러면 끝이에요.

빌드가 잘 안될 경우엔 ``` gradlew clean build ``` 합니다.

build 폴더를 완전히 삭제 했다가 다시 다운 받습니다.

---

> ## 2022-1-7 (금) 🌤

<br/>

ISP PPR INDIGO CLOUD 가상통신 

이쯤에서 한번 내가 작년에 한 일들을 정리 해보자

1. 정보처리기사 땀
2. 공적장부 개발 (그냥 단순한 CRUD)
3. 업무구조도 메뉴 개발 (jsTree 사용)
4. 인접시군구 도로변경 알림 (그냥 단순한 CRUD)
5. SQLD 취득
6. 책 41권 읽기 (적어도 매달 1권씩은 읽음, 변명같지만 중간중간 자격증 취득 책은 빼고 개수를 셈)


---

> ## 2022-1-12 (수) 🌤

<br/>

오늘 데이터 검증하고 SR 처리하다가 보니까 문득.. 내가 SPRING에서 DB 설정 어디서 하는건지도 까먹었단 생각이 들었다.

지금 확인 해보자

잊지말자 JDBC와 DBCP

[JDBC와 DBCP 참고 사이트](https://aljjabaegi.tistory.com/402)


