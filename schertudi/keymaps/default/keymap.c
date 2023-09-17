/* Copyright 2020 Matt3o
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/
#include QMK_KEYBOARD_H
#include "quantum.h"

// Defines names for use in layer keycodes and the keymap
enum layer_names {
    _BASE,
    _FN1,
    _FN2
};


const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
    [0] = LAYOUT(
        KC_ESC,  KC_1,    KC_2,    KC_3,  KC_4, KC_5,    MO(2),        KC_6, KC_7,    KC_8,    KC_9,    KC_0,    KC_NO, \
		KC_TAB, KC_Q,    KC_W,    KC_E,  KC_R, KC_T,    MO(2),        KC_Y, KC_U,    KC_I,    KC_O,    KC_P,    KC_NO, \
		MO(1),  KC_A,    KC_S,    KC_D,  KC_F, KC_G,    LGUI(KC_T),   KC_H, KC_J,    KC_K,    KC_L,    KC_SCLN, MO(1), \
		KC_LSFT, KC_Z,    KC_X,    KC_C,  KC_V, KC_B,    MO(2), KC_N, KC_M,    KC_COMM, KC_DOT,  KC_UP,   KC_RSFT, \
		KC_LCTL, KC_LGUI, KC_LALT, KC_LSFT,   KC_SPC    ,   MO(4),      KC_BSPC,      KC_ENT,   KC_LEFT, KC_DOWN, KC_RIGHT
    ),

    [1] = LAYOUT(
        KC_TRNS, KC_F1,   KC_F2,   KC_F3,   KC_F4,   KC_F5,   KC_NO,   KC_F6,   KC_F7,   KC_F8,   KC_F9,   KC_F10,  KC_F11, \
		KC_TRNS, KC_CIRC, KC_AT,   KC_HASH, KC_DLR,  KC_ASTR, KC_NO,   KC_EXLM, KC_LPRN, KC_RPRN, KC_AMPR, KC_PERC, KC_F12, \
		KC_TRNS, KC_UNDS, KC_EQL,  KC_LCBR, KC_RCBR, KC_PLUS, KC_NO,   KC_MINS, KC_LBRC, KC_RBRC, KC_QUES, KC_COLN, KC_TRNS, \
		KC_NO, KC_GRV,  KC_PIPE, KC_TILD, KC_BSLS, KC_SLSH, KC_NO,   KC_DQT,  KC_QUOT, KC_LT,   KC_GT,   KC_INS,  KC_TRNS, \
		TO(0), KC_TRNS, KC_TRNS, KC_NO,            KC_TRNS, KC_TRNS,  KC_TRNS,          KC_TRNS, KC_END,  KC_DEL,  KC_HOME
    ),

    [2] = LAYOUT(
        QK_BOOT, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO,        KC_NO,        KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, \
		KC_NO,   KC_NO, KC_NO, KC_NO, KC_NO, LCTL(KC_F12), KC_NO,        KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, \
		KC_NO,   KC_NO, KC_NO, KC_NO, KC_NO, KC_NO,        KC_NO,        KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, \
		KC_NO,   KC_NO, KC_NO, KC_NO, KC_NO, LALT(KC_F12), KC_NO,        KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, \
		KC_NO,   KC_NO, KC_NO, KC_NO,        KC_NO,        KC_NO,        KC_NO,        KC_NO, KC_NO, KC_NO, KC_NO  \
    ),

    [3] = LAYOUT(
        KC_ESC,  KC_1,    KC_2,    KC_3,  KC_4, KC_5,    MO(2),        KC_6, KC_7,    KC_8,    KC_9,    KC_0,    KC_PLUS, \
		KC_CAPS, KC_Q,    KC_W,    KC_E,  KC_R, KC_T,    KC_NO,        KC_Y, KC_U,    KC_I,    KC_O,    KC_P,    KC_MINS, \
		KC_TAB,  KC_A,    KC_S,    KC_D,  KC_F, KC_G,    LGUI(KC_T),   S(KC_H), KC_J,    KC_K,    KC_L,    KC_SCLN, KC_ENT, \
	    KC_NO,   KC_Z,    KC_X,    KC_C,  KC_V, KC_B,    LALT(KC_F12), KC_N, KC_M,    KC_COMM, KC_DOT,  KC_UP,   KC_RSFT, \
		KC_LCTL, KC_LGUI, KC_LALT, KC_BSPC,              MO(1),   KC_BSPC,      KC_SPC,      KC_BSPC,   KC_LEFT, KC_DOWN, KC_RIGHT
    ),

    [4] = LAYOUT(
        
		KC_NO, KC_F1, KC_F2, KC_F3, KC_F4, KC_F5, KC_F12, KC_F6, KC_F7, KC_F8, KC_F9, KC_F10, KC_F11, \
		KC_NO, KC_1,  KC_2,  KC_3,  KC_4,  KC_5,  KC_NO,  KC_6,  KC_7,  KC_8,  KC_9,  KC_0,   KC_F12, \
        KC_NO, KC_NO, KC_NO, KC_INS, KC_HOME, KC_PGUP, KC_NO,  KC_NO, KC_NO, KC_NO, KC_NO, KC_NO,  KC_NO, \
		KC_NO, KC_NO, KC_NO, KC_DEL, KC_END, KC_PGDN, KC_NO,  KC_NO, KC_NO, KC_NO, KC_NO, KC_NO,  KC_NO, \
		KC_NO, KC_NO, KC_NO, KC_NO,        KC_NO, KC_NO,  KC_NO,        KC_NO, KC_NO, KC_NO,  KC_NO  \
    ),
    
}; 

