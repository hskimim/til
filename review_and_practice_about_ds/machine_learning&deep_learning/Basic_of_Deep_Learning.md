{
 "cells": [
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "### 신경망 기초 이론\n",
    "- 기저 함수의 형태를 모수 값으로 변화시킬 수 있는 적응형 기저 함수 모형이며 구조적으로는 복수의 퍼셉트론을 쌓아놓은 형태로 MLP(Multi-layer Perceptron)이라고도 부른다.\n",
    "- 일반적으로는 활성화 함수로 시그모이드 함수를 사용하는데 가장 많이 사용하는 활성화 함수는 로지스틱 함수이다.(미분이 편하다.)\n",
    "- 많은 기저 함수를 사용하면, XOR 문제를 해결할 수 있다. 여기서 XOR 문제란 대표적인 비선형 문제를 의미한다.\n",
    "- 신경망 즉, MLP 는 퍼셉트론이 사용하고 있는 로지스틱 시그모이드 함수를 기저 함수로 사용하는 모형이다. \n",
    "- 물론 이러한 기저 함수는 하이퍼 파라미터의 파인 튜닝으로 인해 변경할 수 있다."
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "#### 길어서 끊고 다시 간다."
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "### 신경망 기초 이른\n",
    "- 계속해서 신경망을 다계층 퍼셉트론이라는 언어와 병행하여 사용하고 있는데, 이전에 배웠던 퍼셉트론에 대해서 다시 한 번 짚고 넘어갈 필요가 있다.\n",
    "- 퍼셉트론은 사실 엄청나게 간단한 이론이다. (위대하다)\n",
    "- 함수가 들어간다.(np.dot(W.t,x)+b) 아시다시피 여기서 W : Weight , x : data , b : bias 이다.\n",
    "- 이러한 함수가 채워지면 numerical value를 갖는데, 우리가 풀 문제는 맞다 아니다인 분류 문제이기 때문에, 값을 활성화 함수에 넣고 변환시킨다.\n",
    "- 퍼셉트론에서는 활성화 함수로 로지스틱 시그모이드 함수를 사용한다. MLP에서는 이를 기저 함수로 사용한다. \n",
    "- 다계층 퍼셉트론 즉, 신경망 모델이란 이러한 결정적인 퍼셉트론을 여러 층으로 합쳐 놓고 데이터가 처음 들어가는 퍼셉트론 라인은(라인은 데이터의 사원에 따라서 커진다.) input layer , 가운데에서 데이터가 여러 퍼셉트론 층들을 오고 가면서 튜닝되는 라인(필드)는 hidden layer , 마지막 출력되는 출력 층 ( 층의 갯수는 클래스의 갯수에 따라서 달라진다.)output layer라고 한다."
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "- 순방향 전파\n",
    "    - 신경망의 계산 과정은 실제 신경망에서 신호가 전달되는 과정과 유사하므로 순방향 전파라고 한다.\n",
    "- 역전파\n",
    "    - 단순하게 수치적으로 미분을 계산한다면 모든 가중치에 대해서 갲별적으로 미분을 계산해야 한다. 그러나 역전파 방법을 사용하면 모든 가중치에 대한 미분값을 한번에 계산할 수 있다."
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "### Gradient Vanishing\n",
    "- 기울기와 수렴 속도 문제\n",
    "    - 은닉 계층의 수가 너무 증가하면 수렴 속도 및 성능이 급격히 저하된다.\n",
    "    - 가중치가 감소하는 원인은 역전파 시에 오차가 뉴런을 거치면서 `활성화 함수의 기울기`가 곱해지는데 이 값이 1보다 작아서 계속 크기가 감소한다.\n",
    "    - 일반적으로 사용하는 잔차 제곱합 형태의 오차 함수는 대부분의 경우에 기울기 값이 0이므로, 수렴이 느려지는 단점이 있다.\n",
    "    \n",
    "- 즉, 기울기 소멸 문제를 해결하기 위해 우리가 튜닝해야 하는 부분은 , 로지스틱 함수라는 활성화 함수와, mean-square-error라는 오차함수이다."
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "- 신경망의 예측 성능 및 수렴 성능을 개선하기 위해서는 다음과 같은 추가적인 고려를 해야 한다.\n",
    "    - 오차 함수 개선 : cross_entropy_function \n",
    "    - Activation function : hyper-tangent and Relu \n",
    "    - 가중치 초기값 : weight initialization\n",
    "    - Regularization : Lasso , Ridge , Dropout\n",
    "    - Softmax : output layer Activation function\n",
    "    - Batch Normalization"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "교차 엔트로피 형태의 오차 함수를 사용하면 출력 레이어에서 활성화 함수의 도함수에 의한 영향을 제거할 수 있다."
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "활성화 함수로 로지스틱 함수 대신 하이퍼탄젠트 함수를 사용하면 도함수의 최댓값이 로지스틱 함수의 4배인 1이 되므로 그레디언트 감소 현상이 줄어든다."
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "가장 좋은 방법은 Rectified Linear Unit 활성화 함수를 사용하는 것이다. 가중치 총합이 큰 경우에도 기울기가 항상 1로 유지되므로 가중치 총합이 커도 그레디언트 갑소 현상이 발생하지 않는다. CNN 과 같이 레이어의 수가 많은 경우에 유용하다."
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "뉴런에 대한 입력의 수가 증가하면 가중 총합 값의 표준편차도 증가한다. 이렇게 표준 편차가 크면 수렴이 느려지기 때문에 입력 수에 따라 초기화 가중치의 표준 편차를 감소하는 초기화 값 조정이 필요하다. 많이 사용하는 형태로는 `glorot_uniform`이 있다."
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "- 신경망 모형은 파라미터의 수가 다른 모형에 비해 많다. 이렇게 파라미터의 수가 많으면 과최적화 발생 가능성이 증가한다. 즉, 정확도가 나아지지 않거나 나빠져도 오차 함수는 계속 감소하는 현상이 발생한다. \n",
    "    - L1 정규화는 저번 회귀 분석 시간에 배웠다시피, 절대값 가중치 패널티를 추가하는 것이다.(Lasso)\n",
    "    - L2 정규화는 저번 회귀 분석 시간에 배웠다시피, 제곱합 가중치 패널티를 추가하는 것이다.(Ridge)\n",
    "    - Dropout 정규화 방법은 이러한 문제를 해결하기 위해 epoch 마다 임의의 hidden layer neurons 의 일부를 dropout(떼어낸다.)하여 최적화 과정에 포함하지 않는 방법이다. 이 방법을 사용하면 가중치 값들이 특정한 뉴런에만 집중되는 것을 방지하여 정규화 효과를 가져다 준다."
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "소프트맥스 함수는 입력과 출력이 다변수인 함수이다. 최고 출력의 위치를 변화하지 않으면서, 출력의 합이 1이 되도록 조정하기 대문에 출력에 확률론적 의미를 보여할 수 있다. 보통 신경망의 최종 출력단에 적용한다."
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "- batch_normalization 은 mini-batch 만큼의 트레이닝이 끝날 때마다 가중치 총합의 평균과 분산을 계산해서 평균0 , 분산1이 되도록 정규화해주는 방법이다. \n",
    "    - 정규화를 해주게 되면 무엇이 좋은 것일까?\n",
    "        - 러닝 속도가 빨라진다.\n",
    "        - 층마다 변화하는 공분산 변화에 대한 영향력을 줄여주게 된다.\n",
    "            - 예로 들어서 검정 고양이로 러닝을 하고 유색 고양이로 테스팅을 할 때의 차이를 최대한 줄여주는 것이다.\n",
    "        - 네트워크의 각 층들이 다른 층들과 독립성을 유지한 채,(완전히는 아니고 더욱이다.) 러닝이 가능하게 도와준다."
   ]
  }
 ],
 "metadata": {
  "kernelspec": {
   "display_name": "Python 3",
   "language": "python",
   "name": "python3"
  },
  "language_info": {
   "codemirror_mode": {
    "name": "ipython",
    "version": 3
   },
   "file_extension": ".py",
   "mimetype": "text/x-python",
   "name": "python",
   "nbconvert_exporter": "python",
   "pygments_lexer": "ipython3",
   "version": "3.6.5"
  },
  "latex_envs": {
   "LaTeX_envs_menu_present": true,
   "autoclose": false,
   "autocomplete": true,
   "bibliofile": "biblio.bib",
   "cite_by": "apalike",
   "current_citInitial": 1,
   "eqLabelWithNumbers": true,
   "eqNumInitial": 1,
   "hotkeys": {
    "equation": "Ctrl-E",
    "itemize": "Ctrl-I"
   },
   "labels_anchors": false,
   "latex_user_defs": false,
   "report_style_numbering": false,
   "user_envs_cfg": false
  }
 },
 "nbformat": 4,
 "nbformat_minor": 2
}
