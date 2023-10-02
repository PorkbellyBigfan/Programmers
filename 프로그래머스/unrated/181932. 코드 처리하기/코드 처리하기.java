class Solution {
    public String solution(String code) {
        String answer = "";
        int mode = 0;
        
        for(int i = 0; i<code.length(); i++){
            String str = code.substring(i, i+1); //한글자씩 자르기
            if(mode == 0){ //mode가 0일때,
                if(!str.equals("1")){ //자른 문자열이 '1' 이 아닐때,
                    //idx가 짝수 일 때만, answer의 맨 뒤에 str을 추가.
                    if((i%2==0)){
                        answer += str;
                    }
                } else {
                    //자른 문자열이 '1' 일때, mode를 1으로 변경
                    mode = 1;
                }
            } else { //mode가 1 일때,
                if(!str.equals("1")){ //자른 문자열이 1이 아니면,
                    //idx가 홀수 일 때만, answer의 맨 뒤에 str 추가
                    if((i%2==1)){
                        answer += str;
                    }
                } else { 
                    //자른 문자열이 '1'일 경우엔 mode를 0으로 변경
                    mode = 0;
                }
            }
        }
        if(answer.equals("")){
            answer = "EMPTY";
        }
        return answer;
    }
}