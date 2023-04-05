<script>
import axios from "axios";
export default {
  data() {
    return {
      room_name: null,
      room_id: this.$router.currentRoute.value.params.room_id,
      room_guest_id: this.$router.currentRoute.value.params.room_guest_id,
      guest_id: this.$router.currentRoute.value.params.guest_id,
      guest_name: null,
      chats: [],
      remark: null,
    };
  },
  mounted() {
    this.findRoom();
    this.findGuest();
    setInterval(() => {
      this.getChats();
    }, 5000);
  },
  methods: {
    findRoom() {
      axios
        .get(
          `http://localhost:3000/rooms/${this.$router.currentRoute.value.params.room_id}`
        )
        .then((response) => {
          this.room_name = response.data.name;
          this.getChats();
        })
        .catch((error) => {
          this.$notify({
            type: "error",
            title: "Error",
            message: error,
            position: "bottom-right",
          });
        });
    },
    findGuest() {
      axios
        .get(
          `http://localhost:3000/guests/${this.$router.currentRoute.value.params.guest_id}`
        )
        .then((response) => {
          this.guest_name = response.data.name;
        })
        .catch((error) => {
          this.$notify({
            type: "error",
            title: "Error",
            message: error,
            position: "bottom-right",
          });
        });
    },
    getChats() {
      axios
        .get(`http://localhost:3000/chats?room_id=${this.room_id}`)
        .then((response) => {
          this.chats = response.data;
        })
        .catch((error) => {
          this.$notify({
            type: "error",
            title: "Error",
            message: error,
            position: "bottom-right",
          });
        });
    },
    async appendMessage(val) {
      this.chats.push(val);
    },
    async sendMessage() {
      if (this.remark === "") return;

      axios
        .post("http://localhost:3000/chats", {
          room_id: this.room_id,
          room_guest_id: this.room_guest_id,
          guest_id: this.guest_id,
          guest_name: this.guest_name,
          remark: this.remark,
        })
        .then((response) => {
          if (response.data.status == "success") {
            this.appendMessage(response.data.chat);
            this.remark = null;
          }
        })
        .catch((error) => {
          this.loading = false;
          this.$notify({
            type: "error",
            title: "Error",
            message: error,
            position: "bottom-right",
          });
        });
    },
  },
};
</script>

<template>
  <div class="container mx-auto rounded-lg shadow">
    <div class="max-w-2xl border rounded">
      <div class="w-full">
        <div class="relative flex p-3 border-b border-gray-300">
          <span class="block ml-2 font-bold text-gray-600">{{
            room_name
          }}</span>
        </div>
        <div class="relative w-full p-6 overflow-y-auto h-[30rem]">
          <ul class="space-y-2">
            <div v-for="chat in chats">
              <li v-if="chat.guest_id == guest_id" class="flex justify-end">
                <div class="flex items-center flex-row-reverse mb-4">
                  <div
                    class="flex-none flex flex-col items-center space-y-1 ml-4"
                  >
                    <span
                      class="text-sky-900 block text-xs hover:underline-sky-900"
                      >{{ chat.guest_name }}</span
                    >
                  </div>
                  <div
                    class="flex-1 bg-indigo-100 text-gray-800 p-2 rounded-lg mb-2 relative"
                  >
                    <div>
                      {{ chat.remark }}
                    </div>

                    <!-- arrow -->
                    <div
                      class="absolute right-0 top-1/2 transform translate-x-1/2 rotate-45 w-2 h-2 bg-indigo-100"
                    ></div>
                    <!-- end arrow -->
                  </div>
                </div>
              </li>
              <li v-else class="flex justify-start">
                <div class="flex items-center mb-4">
                  <div
                    class="flex-none flex flex-col items-center space-y-1 mr-4"
                  >
                    <span class="text-sky-900 block text-xs hover:underline">{{
                      chat.guest_name
                    }}</span>
                  </div>
                  <div
                    class="flex-1 bg-indigo-400 text-white p-2 rounded-lg mb-2 relative"
                  >
                    <div>
                      {{ chat.remark }}
                    </div>
                    <!-- arrow -->
                    <div
                      class="absolute left-0 top-1/2 transform -translate-x-1/2 rotate-45 w-2 h-2 bg-indigo-400"
                    ></div>
                    <!-- end arrow -->
                  </div>
                </div>
              </li>
            </div>
          </ul>
        </div>
        <div
          class="flex items-center justify-between w-full p-3 border-t border-gray-300"
        >
          <input
            type="text"
            v-model="remark"
            @keyup.enter="sendMessage()"
            placeholder="Message"
            class="block w-full py-2 pl-4 mx-3 bg-gray-100 rounded-full outline-none focus:text-gray-700"
            name="message"
            required
          />
          <button type="submit" :disabled="!remark" @click="sendMessage()">
            <svg
              class="w-5 h-5 text-gray-500 origin-center transform rotate-90"
              xmlns="http://www.w3.org/2000/svg"
              viewBox="0 0 20 20"
              fill="currentColor"
            >
              <path
                d="M10.894 2.553a1 1 0 00-1.788 0l-7 14a1 1 0 001.169 1.409l5-1.429A1 1 0 009 15.571V11a1 1 0 112 0v4.571a1 1 0 00.725.962l5 1.428a1 1 0 001.17-1.408l-7-14z"
              />
            </svg>
          </button>
        </div>
      </div>
    </div>
  </div>
</template>
