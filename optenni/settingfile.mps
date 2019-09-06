<?xml version="1.0" encoding="UTF-8"?>
<MultiportMatchingCircuitSettings Version="4.1" FileVersion="4.1" SaveDate="23.07.2018 18:48:17">
    <MultiPortDialogSave nport="2" hasDecouplingCircuit="0" isAntenna="1" inductorLossLess="1" capacitorLossLess="1" showBestTopologyOnly="0" alphaInBand="0.05" alphaTotal="0.1" includeSubstrate="1" useInOptimizationNumCases="1" perfOffsetsNumCases="1">
        <Substrate defined="1" epsr="4.8" epsrTol="10" H="1" T="0.01" sigma="5.8e+07" tand="0.017" HTol="5"/>
        <FrequencySetList elem="1">
            <MultiPortFrequencySet name="Set 1">
                <FrequencyModelList n="2">
                    <FrequencyModel n="1">
                        <FrequencyItem startFreqInd="44" endFreqInd="84" startFreq="1.7e+09" endFreq="2.7e+09" label="Mob" frUnit="3">
                            <EfficiencyTargetData targetLevel="0" useReflection="0" reflectionLimit="-10" portString="S11"/>
                        </FrequencyItem>
                    </FrequencyModel>
                    <FrequencyModel n="1">
                        <FrequencyItem startFreqInd="4" endFreqInd="14" startFreq="7e+08" endFreq="9.6e+08" label="Manual" frUnit="3">
                            <EfficiencyTargetData targetLevel="0" useReflection="0" reflectionLimit="-10" portString="S22"/>
                        </FrequencyItem>
                    </FrequencyModel>
                </FrequencyModelList>
                <StopBandModelList n="2">
                    <FrequencyModel n="0"/>
                    <FrequencyModel n="0"/>
                </StopBandModelList>
                <ImpedanceTargetModelList n="2">
                    <FrequencyModel n="0"/>
                    <FrequencyModel n="0"/>
                </ImpedanceTargetModelList>
                <ReflectionTargetModelList n="2">
                    <FrequencyModel n="0"/>
                    <FrequencyModel n="0"/>
                </ReflectionTargetModelList>
                <IsolationModelList n="4">
                    <FrequencyModel n="0"/>
                    <FrequencyModel n="0"/>
                    <FrequencyModel n="2">
                        <FrequencyItem startFreqInd="4" endFreqInd="14" startFreq="7e+08" endFreq="9.6e+08" label="Manual" frUnit="3">
                            <IsolationTargetData targetLevel="-10"/>
                        </FrequencyItem>
                        <FrequencyItem startFreqInd="44" endFreqInd="84" startFreq="1.7e+09" endFreq="2.7e+09" label="Manual" frUnit="3">
                            <IsolationTargetData targetLevel="-10"/>
                        </FrequencyItem>
                    </FrequencyModel>
                    <FrequencyModel n="0"/>
                </IsolationModelList>
                <IsolationPassbandModelsList n="4">
                    <FrequencyModel n="0"/>
                    <FrequencyModel n="0"/>
                    <FrequencyModel n="0"/>
                    <FrequencyModel n="0"/>
                </IsolationPassbandModelsList>
            </MultiPortFrequencySet>
        </FrequencySetList>
        <TopologyList n="2">
            <MultiPortTopologySave autoNC="1" NC="4" useTLSynthesis="0">
                <Circuit cap_esr="0" ind_q="0" ind_q_freq="1" indToler="5" capToler="5" msWidthToler="20" useInductorLibraries="0" useCapacitorLibraries="0" inductorManufacturer="Johanson" inductorSeries="L-07C" inductorDirectory="" capacitorManufacturer="Johanson" capacitorSeries="R07S" capacitorDirectory="" tuned="0" reverse="0">
                    <Series_block orientation="hor" type="series" rootComponent="1" childCount="0" showInsertions="1"/>
                </Circuit>
            </MultiPortTopologySave>
            <MultiPortTopologySave autoNC="1" NC="4" useTLSynthesis="0">
                <Circuit cap_esr="0" ind_q="0" ind_q_freq="1" indToler="5" capToler="5" msWidthToler="20" useInductorLibraries="0" useCapacitorLibraries="0" inductorManufacturer="Johanson" inductorSeries="L-07C" inductorDirectory="" capacitorManufacturer="Johanson" capacitorSeries="R07S" capacitorDirectory="" tuned="0" reverse="1">
                    <Series_block orientation="hor" type="series" rootComponent="1" childCount="0" showInsertions="1"/>
                </Circuit>
            </MultiPortTopologySave>
        </TopologyList>
        <ShortedList n="2">0 0 </ShortedList>
        <LimitData indNoLimits="0" indMin="0.5" indMax="200" capNoLimits="0" capMin="0.5" capMax="200" tlNoLimits="0" tlMin="0.1" tlMax="50" tlCharImpNoLimits="1" tlChMin="0.1" tlChMax="1000" widthNoLimits="0" tlWMin="0.01" tlWMax="20" resNoLimits="1" resMin="0" resMax="1e+06"/>
        <ComponentParameters cap_esr="0" ind_q="0" ind_q_freq="1" indToler="5" capToler="5" msWidthToler="20" useInductorLibraries="0" useCapacitorLibraries="0"/>
        <useInOptimizationList>
            <useInOptimization elem="0" value="1"/>
        </useInOptimizationList>
        <perfOffsetsList>
            <perfOffsets elem="0" value="0"/>
        </perfOffsetsList>
        <MicrostripMatchOptions nomSeriesLength="1" nomSeriesWidth="1" nomStubLength="1" nomStubWidth="1" optimizeSeriesLength="1" optimizeSeriesWidth="1" optimizeStubLength="1" optimizeStubWidth="1" shortOpen="2" stubCircuits="1" steppedCircuits="1" useIdealShort="1" terminationImpedance="50" addPortLines="1" portLineLength="0.1" portLineWidth="1" portLineFreq="1" usePortLineImp="1"/>
    </MultiPortDialogSave>
</MultiportMatchingCircuitSettings>
