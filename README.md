# ExMoya
- 일반적으로 열거형을 사용하여 타입이 안전한 방식으로 네트워크 요청을 캡슐화한 네트워크 계층에서 작업할때 자신감을 제공한다는 개념에서 영감을 얻은 네트워킹 라이브러리
- URLSession → Alamofire → Moya ( 진행방향: 추상화 UP, 편리함 & 코드 간결 UP)

### Moya TargetType Properties
```
public enum MultiTarget : Moya.TargetType {

    /// The embedded `TargetType`.
    case target(Moya.TargetType)

    /// Initializes a `MultiTarget`.
    public init(_ target: Moya.TargetType)

    /// The embedded target's base `URL`.
    public var path: String { get }

    /// The baseURL of the embedded target.
    public var baseURL: URL { get }

    /// The HTTP method of the embedded target.
    public var method: Moya.Method { get }

    /// The sampleData of the embedded target.
    public var sampleData: Data { get }

    /// The `Task` of the embedded target.
    public var task: Moya.Task { get }

    /// The `ValidationType` of the embedded target.
    public var validationType: Moya.ValidationType { get }

    /// The headers of the embedded target.
    public var headers: [String : String]? { get }

    /// The embedded `TargetType`.
    public var target: Moya.TargetType { get }
}
```

- **baseURL**: 서버의 base URL / Moya는 이를 통하여 endpoint 객체 생성
- **path**: 서버의 base URL 뒤에 추가 될 Path(일반적으로 API)
- **method**: HTTP Method
- **sampleData**: 테스트용 Mock Data(테스트를 위한 목업 데이터를 제공할 때 사용)
- **task**: request에 사용되는 파라미터 설정
- **reqeust**
    - **plain request**: 추가 데이터가 없는 reqeust
    - **data request**: 데이터가 포함된 request body
    - **parameter request**: 인코딩된 매개 변수가 있는 request body
    - **JSONEncodable request**: 인코딩 가능한 유형의 request body
    - **upload reqeust**
- **validation Type**: 허용할 response의 타입
- **headers**: HTTP headers
