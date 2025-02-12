// SPDX-License-Identifier: MIT
//
// Copyright (c) 2024 Berachain Foundation
//
// Permission is hereby granted, free of charge, to any person
// obtaining a copy of this software and associated documentation
// files (the "Software"), to deal in the Software without
// restriction, including without limitation the rights to use,
// copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the
// Software is furnished to do so, subject to the following
// conditions:
//
// The above copyright notice and this permission notice shall be
// included in all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
// OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
// HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
// WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
// OTHER DEALINGS IN THE SOFTWARE.

package types

// SlashingInfo represents a slashing info.
//
//go:generate go run github.com/ferranbt/fastssz/sszgen -path slashing_info.go -objs SlashingInfo -include ../../../primitives/pkg/bytes,../../../primitives/pkg/common -output slashing_info.ssz.go
type SlashingInfo struct {
	// Slot is the slot number of the slashing info.
	Slot uint64
	// ValidatorIndex is the validator index of the slashing info.
	Index uint64
}

// New creates a new slashing info instance.
func (s *SlashingInfo) New(slot, index uint64) *SlashingInfo {
	s = &SlashingInfo{
		Slot:  slot,
		Index: index,
	}
	return s
}

// GetSlot returns the slot of the slashing info.
func (s *SlashingInfo) GetSlot() uint64 {
	return s.Slot
}

// GetIndex returns the index of the slashing info.
func (s *SlashingInfo) GetIndex() uint64 {
	return s.Index
}

// SetSlot sets the slot of the slashing info.
func (s *SlashingInfo) SetSlot(slot uint64) {
	s.Slot = slot
}

// SetIndex sets the index of the slashing info.
func (s *SlashingInfo) SetIndex(index uint64) {
	s.Index = index
}
