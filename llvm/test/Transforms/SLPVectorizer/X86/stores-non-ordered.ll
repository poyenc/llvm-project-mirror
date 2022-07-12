; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -S -mtriple=x86_64-unknown -slp-vectorizer -slp-max-store-lookup=2 -slp-min-reg-size=64 -slp-threshold=-1000 | FileCheck %s

define i32 @non-ordered-stores(i32* noalias nocapture %in, i32* noalias nocapture %inn, i32* noalias nocapture %out) {
; CHECK-LABEL: @non-ordered-stores(
; CHECK-NEXT:    [[IN_ADDR:%.*]] = getelementptr inbounds i32, i32* [[IN:%.*]], i64 0
; CHECK-NEXT:    [[LOAD_1:%.*]] = load i32, i32* [[IN_ADDR]], align 4
; CHECK-NEXT:    [[GEP_2:%.*]] = getelementptr inbounds i32, i32* [[IN_ADDR]], i64 2
; CHECK-NEXT:    [[LOAD_3:%.*]] = load i32, i32* [[GEP_2]], align 4
; CHECK-NEXT:    [[TMP1:%.*]] = insertelement <2 x i32*> poison, i32* [[IN_ADDR]], i32 0
; CHECK-NEXT:    [[TMP2:%.*]] = insertelement <2 x i32*> [[TMP1]], i32* [[IN_ADDR]], i32 1
; CHECK-NEXT:    [[TMP3:%.*]] = getelementptr i32, <2 x i32*> [[TMP2]], <2 x i64> <i64 1, i64 3>
; CHECK-NEXT:    [[TMP4:%.*]] = call <2 x i32> @llvm.masked.gather.v2i32.v2p0i32(<2 x i32*> [[TMP3]], i32 4, <2 x i1> <i1 true, i1 true>, <2 x i32> undef)
; CHECK-NEXT:    [[INN_ADDR:%.*]] = getelementptr inbounds i32, i32* [[INN:%.*]], i64 0
; CHECK-NEXT:    [[LOAD_5:%.*]] = load i32, i32* [[INN_ADDR]], align 4
; CHECK-NEXT:    [[GEP_5:%.*]] = getelementptr inbounds i32, i32* [[INN_ADDR]], i64 2
; CHECK-NEXT:    [[LOAD_7:%.*]] = load i32, i32* [[GEP_5]], align 4
; CHECK-NEXT:    [[TMP5:%.*]] = insertelement <2 x i32*> poison, i32* [[INN_ADDR]], i32 0
; CHECK-NEXT:    [[TMP6:%.*]] = insertelement <2 x i32*> [[TMP5]], i32* [[INN_ADDR]], i32 1
; CHECK-NEXT:    [[TMP7:%.*]] = getelementptr i32, <2 x i32*> [[TMP6]], <2 x i64> <i64 1, i64 3>
; CHECK-NEXT:    [[TMP8:%.*]] = call <2 x i32> @llvm.masked.gather.v2i32.v2p0i32(<2 x i32*> [[TMP7]], i32 4, <2 x i1> <i1 true, i1 true>, <2 x i32> undef)
; CHECK-NEXT:    [[MUL_1:%.*]] = mul i32 [[LOAD_1]], [[LOAD_5]]
; CHECK-NEXT:    [[MUL_3:%.*]] = mul i32 [[LOAD_3]], [[LOAD_7]]
; CHECK-NEXT:    [[TMP9:%.*]] = mul <2 x i32> [[TMP4]], [[TMP8]]
; CHECK-NEXT:    br label [[BLOCK1:%.*]]
; CHECK:       block1:
; CHECK-NEXT:    [[GEP_X:%.*]] = getelementptr inbounds i32, i32* [[INN_ADDR]], i64 5
; CHECK-NEXT:    [[LOAD_9:%.*]] = load i32, i32* [[GEP_X]], align 4
; CHECK-NEXT:    br label [[BLOCK2:%.*]]
; CHECK:       block2:
; CHECK-NEXT:    [[GEP_7:%.*]] = getelementptr inbounds i32, i32* [[OUT:%.*]], i64 0
; CHECK-NEXT:    [[GEP_8:%.*]] = getelementptr inbounds i32, i32* [[OUT]], i64 1
; CHECK-NEXT:    [[GEP_9:%.*]] = getelementptr inbounds i32, i32* [[OUT]], i64 2
; CHECK-NEXT:    [[GEP_10:%.*]] = getelementptr inbounds i32, i32* [[OUT]], i64 3
; CHECK-NEXT:    [[GEP_11:%.*]] = getelementptr inbounds i32, i32* [[OUT]], i64 4
; CHECK-NEXT:    store i32 [[MUL_1]], i32* [[GEP_10]], align 4
; CHECK-NEXT:    store i32 [[LOAD_9]], i32* [[GEP_9]], align 4
; CHECK-NEXT:    store i32 [[MUL_3]], i32* [[GEP_11]], align 4
; CHECK-NEXT:    [[TMP10:%.*]] = bitcast i32* [[GEP_7]] to <2 x i32>*
; CHECK-NEXT:    store <2 x i32> [[TMP9]], <2 x i32>* [[TMP10]], align 4
; CHECK-NEXT:    ret i32 undef
;
  %in.addr = getelementptr inbounds i32, i32* %in, i64 0
  %load.1 = load i32, i32* %in.addr, align 4
  %gep.1 = getelementptr inbounds i32, i32* %in.addr, i64 1
  %load.2 = load i32, i32* %gep.1, align 4
  %gep.2 = getelementptr inbounds i32, i32* %in.addr, i64 2
  %load.3 = load i32, i32* %gep.2, align 4
  %gep.3 = getelementptr inbounds i32, i32* %in.addr, i64 3
  %load.4 = load i32, i32* %gep.3, align 4
  %inn.addr = getelementptr inbounds i32, i32* %inn, i64 0
  %load.5 = load i32, i32* %inn.addr, align 4
  %gep.4 = getelementptr inbounds i32, i32* %inn.addr, i64 1
  %load.6 = load i32, i32* %gep.4, align 4
  %gep.5 = getelementptr inbounds i32, i32* %inn.addr, i64 2
  %load.7 = load i32, i32* %gep.5, align 4
  %gep.6 = getelementptr inbounds i32, i32* %inn.addr, i64 3
  %load.8 = load i32, i32* %gep.6, align 4
  %mul.1 = mul i32 %load.1, %load.5
  %mul.2 = mul i32 %load.2, %load.6
  %mul.3 = mul i32 %load.3, %load.7
  %mul.4 = mul i32 %load.4, %load.8
  br label %block1

block1:
  %gep.x = getelementptr inbounds i32, i32* %inn.addr, i64 5
  %load.9 = load i32, i32* %gep.x, align 4
  br label %block2

block2:
  %gep.7 = getelementptr inbounds i32, i32* %out, i64 0
  %gep.8 = getelementptr inbounds i32, i32* %out, i64 1
  %gep.9 = getelementptr inbounds i32, i32* %out, i64 2
  %gep.10 = getelementptr inbounds i32, i32* %out, i64 3
  %gep.11 = getelementptr inbounds i32, i32* %out, i64 4
  store i32 %mul.1, i32* %gep.10, align 4
  store i32 %load.9, i32* %gep.9, align 4
  store i32 %mul.2, i32* %gep.7, align 4
  store i32 %mul.3, i32* %gep.11, align 4
  store i32 %mul.4, i32* %gep.8, align 4

  ret i32 undef
}