//
//  HapticSelectionView.swift
//  NotADiary
//
//  Created by Enzo Ferroni on 06/11/25.
//

import SwiftUI

struct HapticSelectionView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var selectedHaptic: String?
    
    @State private var hapticEngine = EmotionHapticEngine()
    
    private let hapticSections: [(emotion: String, haptics: [(name: String, function: () -> Void)])] = []
    
    init(selectedHaptic: Binding<String?>) {
        self._selectedHaptic = selectedHaptic
    }
    
    var body: some View {
        NavigationStack {
            List {
                // MARK: - Joy Section
                Section("Alegria") {
                    HapticRowView(
                        name: "Saltitante",
                        isSelected: selectedHaptic == "joy_bouncy",
                        action: {
                            selectedHaptic = "joy_bouncy"
                            hapticEngine.playJoyBouncy()
                        }
                    )
                    
                    HapticRowView(
                        name: "Caloroso",
                        isSelected: selectedHaptic == "joy_warm",
                        action: {
                            selectedHaptic = "joy_warm"
                            hapticEngine.playJoyWarm()
                        }
                    )
                    
                    HapticRowView(
                        name: "Edificante",
                        isSelected: selectedHaptic == "joy_uplifting",
                        action: {
                            selectedHaptic = "joy_uplifting"
                            hapticEngine.playJoyUplifting()
                        }
                    )
                    
                    HapticRowView(
                        name: "Brilhante",
                        isSelected: selectedHaptic == "joy_sparkle",
                        action: {
                            selectedHaptic = "joy_sparkle"
                            hapticEngine.playJoySparkle()
                        }
                    )
                }
                
                // MARK: - Sadness Section
                Section("Tristeza") {
                    HapticRowView(
                        name: "Pesado",
                        isSelected: selectedHaptic == "sadness_heavy",
                        action: {
                            selectedHaptic = "sadness_heavy"
                            hapticEngine.playSadnessHeavy()
                        }
                    )
                    
                    HapticRowView(
                        name: "Melancolia",
                        isSelected: selectedHaptic == "sadness_melancholy",
                        action: {
                            selectedHaptic = "sadness_melancholy"
                            hapticEngine.playSadnessMelancholy()
                        }
                    )
                    
                    HapticRowView(
                        name: "Lacrimoso",
                        isSelected: selectedHaptic == "sadness_tearful",
                        action: {
                            selectedHaptic = "sadness_tearful"
                            hapticEngine.playSadnessTearful()
                        }
                    )
                    
                    HapticRowView(
                        name: "Afundando",
                        isSelected: selectedHaptic == "sadness_sinking",
                        action: {
                            selectedHaptic = "sadness_sinking"
                            hapticEngine.playSadnessSinking()
                        }
                    )
                }
                
                // MARK: - Fear Section
                Section("Medo") {
                    HapticRowView(
                        name: "Peito Apertado",
                        isSelected: selectedHaptic == "fear_tight_chest",
                        action: {
                            selectedHaptic = "fear_tight_chest"
                            hapticEngine.playFearTightChest()
                        }
                    )
                    
                    HapticRowView(
                        name: "Pavor",
                        isSelected: selectedHaptic == "fear_dread",
                        action: {
                            selectedHaptic = "fear_dread"
                            hapticEngine.playFearDread()
                        }
                    )
                    
                    HapticRowView(
                        name: "Susto",
                        isSelected: selectedHaptic == "fear_jump_scare",
                        action: {
                            selectedHaptic = "fear_jump_scare"
                            hapticEngine.playFearJumpScare()
                        }
                    )
                    
                    HapticRowView(
                        name: "Tremendo",
                        isSelected: selectedHaptic == "fear_trembling",
                        action: {
                            selectedHaptic = "fear_trembling"
                            hapticEngine.playFearTrembling()
                        }
                    )
                }
                
                // MARK: - Love Section
                Section("Amor") {
                    HapticRowView(
                        name: "Batimento Cardíaco",
                        isSelected: selectedHaptic == "love_heartbeat",
                        action: {
                            selectedHaptic = "love_heartbeat"
                            hapticEngine.playLoveHeartbeat()
                        }
                    )
                    
                    HapticRowView(
                        name: "Terno",
                        isSelected: selectedHaptic == "love_tender",
                        action: {
                            selectedHaptic = "love_tender"
                            hapticEngine.playLoveTender()
                        }
                    )
                    
                    HapticRowView(
                        name: "Borboletas",
                        isSelected: selectedHaptic == "love_butterflies",
                        action: {
                            selectedHaptic = "love_butterflies"
                            hapticEngine.playLoveButterflies()
                        }
                    )
                    
                    HapticRowView(
                        name: "Apaixonado",
                        isSelected: selectedHaptic == "love_passionate",
                        action: {
                            selectedHaptic = "love_passionate"
                            hapticEngine.playLovePassionate()
                        }
                    )
                }
                
                // MARK: - Anger Section
                Section("Raiva") {
                    HapticRowView(
                        name: "Fúria",
                        isSelected: selectedHaptic == "anger_rage",
                        action: {
                            selectedHaptic = "anger_rage"
                            hapticEngine.playAngerRage()
                        }
                    )
                    
                    HapticRowView(
                        name: "Tensão",
                        isSelected: selectedHaptic == "anger_tension",
                        action: {
                            selectedHaptic = "anger_tension"
                            hapticEngine.playAngerTension()
                        }
                    )
                    
                    HapticRowView(
                        name: "Golpe",
                        isSelected: selectedHaptic == "anger_strike",
                        action: {
                            selectedHaptic = "anger_strike"
                            hapticEngine.playAngerStrike()
                        }
                    )
                    
                    HapticRowView(
                        name: "Explosivo",
                        isSelected: selectedHaptic == "anger_explosive",
                        action: {
                            selectedHaptic = "anger_explosive"
                            hapticEngine.playAngerExplosive()
                        }
                    )
                }
                
                // MARK: - Surprise Section
                Section("Surpresa") {
                    HapticRowView(
                        name: "Suspiro",
                        isSelected: selectedHaptic == "surprise_gasp",
                        action: {
                            selectedHaptic = "surprise_gasp"
                            hapticEngine.playSurpriseGasp()
                        }
                    )
                    
                    HapticRowView(
                        name: "Momento Aha",
                        isSelected: selectedHaptic == "surprise_oh_moment",
                        action: {
                            selectedHaptic = "surprise_oh_moment"
                            hapticEngine.playSurpriseOhMoment()
                        }
                    )
                    
                    HapticRowView(
                        name: "Encantado",
                        isSelected: selectedHaptic == "surprise_delighted",
                        action: {
                            selectedHaptic = "surprise_delighted"
                            hapticEngine.playSurpriseDelighted()
                        }
                    )
                    
                    HapticRowView(
                        name: "Choque",
                        isSelected: selectedHaptic == "surprise_shock",
                        action: {
                            selectedHaptic = "surprise_shock"
                            hapticEngine.playSurpriseShock()
                        }
                    )
                }
            }
            .navigationTitle("Selecionar Vibração")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "checkmark")
                    }
                }
            }
        }
    }
}

struct HapticRowView: View {
    let name: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Text(name)
                    .foregroundColor(.primary)
                
                Spacer()
                
                if isSelected {
                    Image(systemName: "checkmark")
                        .foregroundColor(.accentColor)
                }
                
                Image(systemName: "waveform.path")
                    .foregroundColor(.secondary)
            }
        }
    }
}

#Preview {
    HapticSelectionView(selectedHaptic: .constant(nil))
}
