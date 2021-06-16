class Solution {
    std::pair<bool, int> verify_chars(std::string& s, int length) {
        int e_index = -1;
        for (size_t i = 0; i < length; ++i) {
            if (!((s[i] >= '0' && s[i] <= '9') || 
                s[i] == 'e' || s[i] == 'E' || 
                s[i] == '+' || s[i] == '-' || s[i] == '.')) return {false, e_index};

            if (s[i] == 'e' || s[i] == 'E') e_index = i;
        }
        return {true, e_index};
    }
    bool is_number(std::string& s, int l, int r, bool integer_only) {
        if (l > r) return false;
        bool sign = false;
        int dot_index = -1, digits = 0;
        for (int i = l; i <= r; ++i) {
            if (s[i] == '+' || s[i] == '-') {
                sign = true;
                if (i != l) return false;
            } 
            else if (s[i] >= '0' && s[i] <= '9') { digits++; }
            else if (s[i] == '.') { dot_index = i; }
        }

        if (digits == 0) return false;

        if (integer_only) { if (dot_index != -1) return false; }

        if (dot_index == -1) {
            // integer with sign
            if (sign) {
                //std::cout << "integer with sign" << '\n';
                if (digits != r-l+1-1) return false;
            }
            else {
                //std::cout << "integer without sign" << '\n';
                if (digits != r-l+1) return false;
            }
        }
        else {
            // decimal with sign
            if (sign) {
                //std::cout << "decimal with sign" << '\n';
                if (digits != r-l+1-2) return false;
            }
            else {
                //std::cout << "decimal without sign" << '\n';
                if (digits != r-l+1-1) return false;
            }
        }
        return true;
    }
public:
    bool isNumber(string s) {
        int n = s.size();
        auto res = verify_chars(s, n);
        if (!res.first) return false;
        // res.second is e or E's index
        if (res.second != -1) {
            bool first = is_number(s, 0, res.second-1, false);
            bool second = is_number(s, res.second+1, n-1, true);
            return first && second;
        }
        else {
            return is_number(s, 0, n-1, false);
        }
    }
};
