var WebSquareLang = {

	E_core_lee : " 이정인  "	,
	
	//Actions.js
	E_Actions_fileuploadPopupName : "파일업로드 : %1",
	
	//date.js
	E_date_ShouldBeyyMMddFormat : "입력값은 yyyyMMdd형식이어야 합니다. 입력값 : %1",
	E_date_ShouldBeNumberFormat : "입력값은 숫자형식이어야 합니다. 입력값 : %1",
	E_date_YearRange : "연도는 %1부터 %2사이 값이어야 합니다. 입력값 : %3",
	E_date_MonthRange : "월은 %1부터 %2사이 값이어야 합니다. 입력값 : %3",
	E_date_DayRange : "일은 %1부터 %2사이 값이어야 합니다. 입력값 : %3",

	//exception.js
	E_exception_ErrorOccursSeeLog : "작업 도중 오류가 발생하였습니다.\n\n%1",
	E_exception_IERuntimeError : "Runtime Error\n\n줄 No.    : %1 \n문자 : %2\n코드 : %3\nURL : %4\n오류 : %5\n원본 : %6",
	E_exception_FFRuntimeError : "Runtime Error\n\n줄 No.    : %1 \nURL : %2 \n오류 : %3 \n원본 : %4 ",

	//form.js
	E_form_TimeKeyUpWrongHourFormat : "시간 입력이 잘못되었습니다.",
	E_form_TimeKeyUpWrongMinuteFormat : "분 입력이 잘못되었습니다.",

	//initializer.js
	E_initializer_XMLLoadFailError : "W2X 파일을 읽어들이는데 실패했습니다. 경로를 확인하세요. URL [ %1 ]",
	E_initializer_XMLLoadFailError1: "읽어들인 W2X 파일을 처리하는데 실패했습니다. URL [ %1 ]",

	//logger.js
	E_logger_ContextmenuSeeLog : "로그보기",
	E_logger_ContextmenuSeePerformanceLog : "성능로그보기",
	E_logger_ContextmenuSeeAddress : "주소",
	E_logger_ContextmenuSeeSource : "소스보기",
	E_logger_ContextmenuSeeFiddle : "Fiddle 보기",
	E_logger_ContextmenuStopDebugOnScreen : "현재 화면 디버그 중단",
	E_logger_ContextmenuStartDebugOnScreen : "현재 화면 디버그 실행",
	E_logger_ContextmenuStopDebugOnSystem : "전체 시스템 디버그 중단",
	E_logger_ContextmenuStartDebugOnSystem : "전체 시스템 디버그 실행",
	E_logger_ContextmenuPrint : "인쇄",
	E_logger_ContextmenuRefresh : "새로고침",
	E_logger_ContectmenuFileInfo : "File 정보",
	E_logger_ContextmenuVersion : "Version 정보",
	E_logger_ContextmenuChangeClientName : "Client Name변경",
	E_logger_EnterPassword : "비밀번호를 입력하세요.",
	E_logger_IncorrectPassword : "비밀번호가 일치하지 않습니다.",
	E_logger_ObjectDisabled : "객체가 disable되어 있습니다.",
	E_logger_UsedXSLInfo : "사용한 XSL : %1",
	E_logger_NoUsedXSLInfo : "객체를 그리는데 사용한 XSL이 없습니다.",
	E_logger_InnerBlindObject : "[내부 구조를 볼 수 없는 Object입니다.]\n\n",
	E_logger_InitDueToOverline : "%1 [%2] 로그가 500줄 이상 되서 로그를 초기화 합니다.",
	E_logger_ObjectInfo : "Object 정보",
	E_logger_XSLInfo : "XSL 정보",
	E_logger_changeClientName : "원격 디버깅에 사용할 Client Name를 입력하세요.",

	//Model.js
	E_Model_NoChildNodeOfInstance : "해당 instance의 child node가 존재하지 않습니다.",

	//ModelUtil.js
	E_ModelUtil_NoSubmissionObjectWithID : "submission 객체[ %1 ]가 존재하지 않습니다.",
	E_ModelUtil_NoSubmissionObject : "submission 객체가 존재하지 않습니다.",
	//net.js
	E_net_PopupBlocked : "팝업이 차단되었습니다.",

	//Parser.js
	E_Parser_MoreThanOneHeadError : "WebSquare의 Head는 하나만 허용됩니다. 현재 XML은 Head가 '%1'개 입니다.",
	E_Parser_MoreThanOneBodyError : "WebSquare의 Body는 하나만 허용됩니다. 현재 XML은 Body가 '%1'개 입니다.",

	//WebSquareDocument.js
	E_WebSquareDocument_MoreThanOneBodyError : "WebSquare의 Body는 하나만 허용됩니다. 현재 XML은 Body가 '%1'개 입니다.",

	//xml.js
	E_xml_XMLUnsupportedBrowser : "XML을 지원하지 않는 브라우저 입니다.",
	E_xml_ErrorOccurLoadingXMLWithURL : "XML을 Loading하던 중 Error가 발생했습니다.\n\nURL : %1",
	E_xml_ErrorOccurLoadingXML : "XML을 Loading하던 중 Error가 발생했습니다.\n",
	E_xml_ErrorOccurParsingXML : "XML을 Parsing하던 중 Error가 발생했습니다.\n",

	//core.js
	E_core_AjaxUnsupportedBrowser : "Ajax를 지원하지 않는 브라우저 입니다." ,
	E_core_NoPluginError : "Plugin[ %1 ]이 존재하지 않습니다.",
	E_core_NoModuleError : "Module[ %1 ]이 존재하지 않습니다.",

	//event.js
	E_event_AddEventError : "id가 없는 HTML객체가 존재하거나 현재 버전에서는 지원하지 않는 Action[ %1 ] 이 사용되었습니다.",

	//logMsg.html
	E_logMsg_LogInfo : "Log 정보입니다.",
	E_logMsg_LogAutoRenewal : "자동갱신 중",
	E_logMsg_LogAutoRenewalStop : "자동갱신 중단",

	//viewSource.html
	E_viewSource_title : "Source Information.",

	//debugMsg.html
	E_debugMsg_DebugInfo : "Debug 정보입니다.",

	//processMsg.html
	E_processMsg_Processing : "처리 중입니다.",

	//errorMsg.html
	E_errorMsg_ErrorInfo : "Error 정보입니다.",
	
	V_error_minLength : "최소 %1 자리 이상 입력해야 합니다.",
	V_error_maxLength : "최대 %1 자리 이상 입력할 수 없습니다.",
	V_error_minByteLength : "최소 %1 byte 이상 입력해야 합니다.",
	V_error_maxByteLength : "최대 %1 byte 이상 입력할 수 없습니다.",
	V_error_validCondition : "Validator의 수행 조건을 만족하지 못했습니다.",
	V_error_no_valiator : "Validator가 존재하지 않거나 객체가 아닙니다.",
	V_error_mandatory : "필수 입력 항목입니다",
	V_error_allowChar : "허용된 문자열은 %1 입니다",
	V_error_ignoreChar : "허용되지 않은 문자열은 %1 입니다",
	V_error_date : "날짜 형식이 잘못 되었습니다.",
	
	IC_Mask : "yyyy-MM-dd",
	IC_Delimiter : "-",
	IC_invalidCalendarSelect : "날짜 형식이 잘못 되었습니다.",
	
	GRID_noResultMsg : "조회결과가 없습니다.",
	
	SelectBox_all : "-전체-",
	SelectBox_choose : "-선택-",

	// Calendar
	Calendar_select_year : "해 선택",
	Calendar_select_month : "달 선택",
	Calendar_select_hour : "시 선택",
	Calendar_select_minute : "분 선택",
	Calendar_previous_year : "이전 해",
	Calendar_previous_month : "이전 달",
	Calendar_next_year : "다음 해",
	Calendar_next_month : "다음 달",
	Calendar_open : "달력에서 선택",
	Calendar_ok : "확인",
	Calendar_close : "닫기",
	Calendar_cancel : "취소",
	Calendar_today : "현재일",
	Calendar_weekdaynames_0 : "일요일",
	Calendar_weekdaynames_1 : "월요일",
	Calendar_weekdaynames_2 : "화요일",
	Calendar_weekdaynames_3 : "수요일",
	Calendar_weekdaynames_4 : "목요일",
	Calendar_weekdaynames_5 : "금요일",
	Calendar_weekdaynames_6 : "토요일",
	Calendar_name : "달력",
	Calendar_caption : "달력",
	Calendar_summary : "달력",

	// Pagelist
	Pagelist_first_page : "첫 페이지",
	Pagelist_previous_page : "이전 페이지",
	Pagelist_next_page : "다음 페이지",
	Pagelist_last_page : "마지막 페이지",
	
	// Window
	Window_minimize : "창사이즈 최소화",
	Window_restore : "창사이즈 복원",
	Window_close : "창닫기"
} 