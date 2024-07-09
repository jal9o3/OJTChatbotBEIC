import streamlit as st

# Initialize session state for checkboxes and button states
if 'checkbox_states' not in st.session_state:
    st.session_state.checkbox_states = {
        'checkbox1': False,
        'checkbox2': False,
        'checkbox3': False,
        # Add as many checkboxes as you need initially
    }

if 'button_disabled' not in st.session_state:
    st.session_state.button_disabled = {
        'add_checkbox': False,
        'reset': False,
    }

# Function to reset checkboxes
def reset_checkboxes():
    for key in st.session_state.checkbox_states.keys():
        st.session_state.checkbox_states[key] = False
    st.session_state.button_disabled['reset'] = True
    st.experimental_rerun()

# Function to add a new checkbox
def add_checkbox():
    new_key = f'checkbox{len(st.session_state.checkbox_states) + 1}'
    st.session_state.checkbox_states[new_key] = False
    st.session_state.button_disabled['add_checkbox'] = True
    st.experimental_rerun()

# Display checkboxes
for key in st.session_state.checkbox_states:
    st.session_state.checkbox_states[key] = st.checkbox(key.replace('_', ' ').title(), st.session_state.checkbox_states[key])

# Add button to add a new checkbox
if st.button('Add Checkbox', disabled=st.session_state.button_disabled['add_checkbox']):
    add_checkbox()

# Reset button
if st.button('Reset', disabled=st.session_state.button_disabled['reset']):
    reset_checkboxes()

# Optional: Display the states of the checkboxes
st.write(st.session_state.checkbox_states)
