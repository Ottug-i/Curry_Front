// 레시피 데이터에서 ###로 나뉘어진 문자열을 리스트로 바꾸기

List<String> hashToList(String longText) {
 return longText.split('###');
}